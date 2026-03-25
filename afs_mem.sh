#!/bin/bash

# SPDX-FileCopyrightText: 2026 ENEA
# SPDX-FileContributor: Alberto Previti
#
# SPDX-License-Identifier: MPL-2.0

set -e -u -o pipefail


get_afs_name_details() {
    pts examine -nameorid "$1" | \
      head -n 1 | sed 's/,[ \t]*$//' | \
      jq --raw-input --sort-keys 'ascii_downcase | split(", ") | map(split(": ")) | map({(.[0] | .): (.[1] | tonumber? // .)}) | add'
}


get_afs_owned_list() {
    pts listowned -nameorid "$1" | \
      tail -n +2 | \
      sed 's/^[ \t]*//' | \
      jq --raw-input --null-input '[inputs] | sort'

}


get_afs_membership_list() {
    pts membership -nameorid "$1" | \
      tail -n +2 | \
      sed 's/^[ \t]*//' | \
      jq --raw-input --null-input '[inputs] | sort'
}


is_afs_user_id() {
    if (( "$1" > 0)); then

        return 0
    else
        return 1
    fi
}


is_afs_group_id() {
    if (( "$1" > 0)); then
        return 1
    else
        return 0
    fi
}


get_afs_membership_user_list() {
    local -a users
    while read -r afs_name; do
        local afs_name_clean=$(echo $afs_name | xargs)
        local afs_id=$(get_afs_name_details $afs_name_clean | jq '.id')
        if is_afs_user_id $afs_id; then
            users+=($afs_name_clean)
        fi
    done < <(get_afs_membership_list "$1" | jq --compact-output '.[]')

    echo ${users[@]}
}


get_afs_membership_group_list() {
    local -a users
    while read -r afs_name; do
        local afs_name_clean=$(echo $afs_name | xargs)
        local afs_id=$(get_afs_name_details $afs_name_clean | jq '.id')
        if is_afs_group_id $afs_id; then
            users+=($afs_name_clean)
        fi
    done < <(get_afs_membership_list "$1" | jq --compact-output '.[]')

    echo ${users[@]}
}


get_afs_owned_user_list() {
    local -a users
    while read -r afs_name; do
        local afs_name_clean=$(echo $afs_name | xargs)
        local afs_id=$(get_afs_name_details $afs_name_clean | jq '.id')
        if is_afs_user_id $afs_id; then
            users+=($afs_name_clean)
        fi
    done < <(get_afs_owned_list "$1" | jq --compact-output '.[]')

    echo ${users[@]}

}


get_afs_owned_group_list() {
    local -a users
    while read -r afs_name; do
        local afs_name_clean=$(echo $afs_name | xargs)
        local afs_id=$(get_afs_name_details $afs_name_clean | jq '.id')
        if is_afs_group_id $afs_id; then
            users+=($afs_name_clean)
        fi
    done < <(get_afs_owned_list "$1" | jq --compact-output '.[]')

    echo ${users[@]}

}


get_afs_users_recursive() {
    local -A user_dict

    user_dict["$1"]=$(get_afs_membership_user_list "$1")

    for afs_group in $(get_afs_owned_group_list "$1")
    do
        user_dict[${afs_group}]=$(get_afs_membership_user_list $afs_group)
    done

    local -a args
    for key in "${!user_dict[@]}"
    do
        args+=(--arg "$key" "${user_dict[$key]}")
    done
    jq --sort-keys --null-input "${args[@]}" '$ARGS.named | map_values(split(" "))'
}
