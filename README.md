<!--
SPDX-FileCopyrightText: 2026 ENEA
SPDX-FileContributor: Alberto Previti

SPDX-License-Identifier: MPL-2.0
-->

# AFS utilities

Bash script to parse Andrew File System users and groups and produce [JSON](https://www.json.org) outputs.

[![basher install](https://www.basher.it/assets/logo/basher_install.svg)](https://www.basher.it/package/)
![Shell Script](https://img.shields.io/badge/Shell_Script-121011?style=flat&logo=gnu-bash&logoColor=white)

## Installation
```bash
basher install ENEA-Fusion-Neutronics/afs-utils
```

If needed, [basher](https://github.com/basherpm/basher) may be installed with
```bash
curl -s https://raw.githubusercontent.com/basherpm/basher/master/install.sh | bash
```

## Usage

| Command                                    | Action                                                  |
| :----------------------------------------- | :------------------------------------------------------ |
| `afs-mem name-details <afs_name>`          | Get details about an AFS user or group                  |
| `afs-mem owned-list <afs_name>`            | List all users and groups owned                         |
| `afs-mem owned-user-list <afs_name>`       | List users owned                                        |
| `afs-mem owned-group-list <afs_name>`      | List groups owned                                       |
| `afs-mem membership-list <afs_name>`       | List all members                                        |
| `afs-mem membership-user-list <afs_name>`  | List user members                                       |
| `afs-mem membership-group-list <afs_name>` | List group members                                      |
| `afs-mem users-recursive <afs_name>`       | Recursively list all users in a group and its subgroups |

## Requirements

- [`bash`](https://www.gnu.org/software/bash/) >= 4.0
- AFS utilities ([`pts`](https://docs.openafs.org/Reference/1/pts.html) command)
- [`jq`](https://jqlang.org/) for JSON processing
- Standard POSIX utilities (`sed`, `head`, `tail`)
