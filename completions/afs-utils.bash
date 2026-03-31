# SPDX-FileCopyrightText: 2026 ENEA
# SPDX-FileContributor: Alberto Previti
#
# SPDX-License-Identifier: MPL-2.0


_afs_mem() {
    local cur prev words cword
    _init_completion || return

    local commands="name-details owned-list membership-list membership-user-list membership-group-list owned-user-list owned-group-list users-recursive"

    if [[ $cword -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "$commands" -- "$cur") )
    else
        COMPREPLY=()
    fi
} &&
complete -F _afs_mem afs-mem


_afs_acl() {
    local cur prev words cword
    _init_completion || return

    local commands="path"

    if [[ $cword -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "$commands" -- "$cur") )
    else
        COMPREPLY=()
    fi
} &&
complete -F _afs_acl afs-acl
