# Remote 速查表 / Cheatsheet

## remote 系列（sshfs 挂载）

| 命令 | 说明 |
|------|------|
| `remote mount <主机> <远程路径>` | 挂载远程目录到 `~/mnt/<主机>/` |
| `remote umount <主机>` | 卸载 |
| `remote open <主机> <远程路径>` | 挂载 + 自动打开 Neovide |
| `remote list` | 查看已挂载的 + 可用 SSH 主机 |

**示例：**
```bash
remote mount aeza_vps /root     # 挂载 aeza_vps:/root → ~/mnt/aeza_vps/
remote open aeza_vps /root      # 同上 + 自动打开 Neovide
remote list                     # 看挂载状态和所有 SSH 主机
```

## SSH 快捷命令

| 命令 | 说明 | 示例 |
|------|------|------|
| `ls_s <主机> <远程路径>` | 远程列出文件 | `ls_s aeza_vps /root` |
| `mv_s <主机> <旧路径> <新路径>` | 远程移动/重命名 | `mv_s aeza_vps /old /new` |
| `put_s <本地文件> <主机:远程路径>` | scp 上传 | `put_s ./file.txt aeza_vps:/root/` |
| `get_s <主机:远程路径> [本地路径]` | scp 下载 | `get_s aeza_vps:/root/file.txt ./` |

## Neovide 启动

| 命令 | 说明 |
|------|------|
| `nv` | Neovide + 普通 Neovim（自动进 `~/notes`） |
| `lv` | Neovide + LunarVim（自动进 `~/notes`） |

## 可用 SSH 主机

```
aeza_vps, aeza_vps_2, alpha_vps, web3cipher
home_linux_1, home_linux_2, home_linux_3, home_fnos
liu_linux, liu_linux_rjman, liu_linux_liu
autodl, autodl-3090
oracle, oracle-1
parallel-dev, parallel-l2-node-1, parallel-l2-node-2
dev, bot, build_server, remote_server
```
