# SPDX-FileCopyrightText: 2026 ENEA
# SPDX-FileContributor: Alberto Previti
#
# SPDX-License-Identifier: MPL-2.0


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
