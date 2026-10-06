# /etc 改动清单

> **用途**：重装系统或迁移到新机器时，照着这份表把 /etc 恢复到位。
> **维护**：每次改完 /etc 就顺手更新这里（这是唯一防"我忘了改啥"的纪律）。
> **图例**：✅ 已确认改动 ｜ ❓ 待确认 ｜ ⚙️ 工具自动生成/管理，**勿手工同步**

---

## 一、速查表（模块 → 路径）

| 模块 | 路径 | 状态 |
| --- | --- | --- |
| **引导参数** | `/etc/default/grub` | ✅ |
| 引导镜像 | `/etc/mkinitcpio.conf` | ✅ |
| 引导镜像产物 | `/etc/mkinitcpio.d/*.preset` | ⚙️ |
| **zram** | `/etc/systemd/zram-generator.conf` | ✅ |
| **zswap** | `/etc/default/grub`（cmdline: `zswap.enabled=0`） | ✅ |
| **包管理** | `/etc/pacman.conf` | ✅ |
| 镜像源 | `/etc/pacman.d/mirrorlist`、`/etc/pacman.d/archlinuxcn-mirrorlist` | ⚙️ |
| **快照 snapper** | `/etc/snapper/configs/root`、`/etc/conf.d/snapper` | ✅ |
| **电源 TLP** | `/etc/tlp.conf`、`/etc/tlp.d/*.conf` | ✅ |
| **登录 SDDM** | `/etc/sddm.conf.d/theme.conf` | ✅ |
| **全局环境变量** | `/etc/environment` | ✅ |

---

## 二、逐模块的重建方式

### 1. 时区 / 语言 / 键盘 / 主机名（用命令，别拷文件）

```bash
timedatectl set-timezone Asia/Shanghai
localectl set-locale LANG=zh_CN.UTF-8      # 对应 /etc/locale.conf
localectl set-keymap <你的键位>             # 对应 /etc/vconsole.conf
hostnamectl set-hostname Arch
# /etc/locale.gen：取消注释需要的 locale，然后
locale-gen
```

### 2. zram / zswap

- **zram** → `/etc/systemd/zram-generator.conf`

  ```ini
  [zram0]
  zram-size = "ram*1"
  compression-algorithm = zstd
  ```

  装 `zram-generator` 后放好此文件即可（`systemctl daemon-reload`）。
- **zswap** → 在 `/etc/default/grub` 的 `GRUB_CMDLINE_LINUX_DEFAULT` 里保持 **关闭**：

  ```
  zswap.enabled=0 loglevel=3 quiet
  ```

  ⚠️ 与 zram 同时开启是反模式（内存里压两遍）。
- 改完 grub **必须重新生成**：

  ```bash
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  cat /proc/cmdline        # 验证生效
  ```

### 3. 包管理

- `/etc/pacman.conf`：加 `[archlinuxcn]` 段、`ParallelDownloads`、颜色等
- 装 archlinuxcn 的 keyring：`pacman -S archlinuxcn-keyring`
- 镜像源不要手工同步（`/etc/pacman.d/mirrorlist` 用 reflector 或安装器生成）

### 4. 快照（snapper）

- `/etc/snapper/configs/root`：清理策略（`TIMELINE_LIMIT_*`、`NUMBER_LIMIT`）
- `/etc/conf.d/snapper`：`SNAPPER_CONFIGS="root"`（systemd timer 读它）
- 装完确认定时器：`systemctl enable --now snapper-timeline.timer snapper-cleanup.timer`

### 5. 电源（TLP）

- 优先把改动写在 `/etc/tlp.d/*.conf`（比直接改 23KB 的 `/etc/tlp.conf` 好维护）
- 启用：`systemctl enable --now tlp.service`

### 6. 登录（SDDM）

- `/etc/sddm.conf.d/theme.conf`：主题等
- 注意 SDDM 默认配置文件是 `/usr/lib/sddm/sddm.conf.d/default.conf`，**改动放 `conf.d/` 覆盖**

### 7. 网络 / 防火墙

- `/etc/nftables.conf` → `systemctl enable --now nftables.service`
- DNS 交给 NetworkManager，**不要手改 `/etc/resolv.conf`**

### 8. 全局环境变量

- `/etc/environment`：由 PAM(`pam_env`) 读取，**所有登录方式**（TTY/greetd/SSH）都生效
- 想更现代一点可迁到 `~/.config/environment.d/*.conf`（只影响 systemd 用户会话）

### 9. sudo / 用户组

- `/etc/sudoers`：`%wheel` 行（改完必须 `visudo` 校验）
- 组：`usermod -aG video,input,wheel <user>`

---

## 三、永远不要手工同步 / 外传的文件

| 路径 | 原因 |
| --- | --- |
| `/etc/pacman.d/gnupg/` | ⚠️ **含 pacman 私钥**（`secring.gpg`、`private-keys-v1.d/*.key`） |
| `/etc/NetworkManager/system-connections/` | ⚠️ **WiFi 密码明文** |
| `/etc/machine-id` | 每台机器必须唯一 |
| `/etc/shadow`、`/etc/gshadow`、`/etc/*-` | 凭据 + shadow 工具自动备份 |
| `/etc/resolv.conf`、`/etc/adjtime`、`/etc/ld.so.cache` | 被工具持续改写 |
| `/etc/group`、`/etc/passwd`、`/etc/subuid`、`/etc/subgid` | 由 `useradd`/装包管理 |
| `/etc/fstab`、`/etc/mkinitcpio.d/*.preset` | 机器相关（UUID/磁盘） |
| `/etc/ssh/ssh_host_*` | 主机私钥，换机必须重新生成 |
| `/etc/ssl/`、`/etc/ca-certificates/` | 由 `update-ca-trust` 生成 |

---
