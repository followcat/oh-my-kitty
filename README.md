# Oh My FollowCat Kitty 🐱

一个优雅的 Kitty 终端配置，包含 Guake 风格的下拉窗口功能。

## 功能特点

- 🎯 **Guake 风格下拉终端** - 按 `Ctrl+` `` 快速呼出/隐藏
- ⌨️ **快捷键控制** - `Ctrl+上/下` 调整窗口高度
- 🎨 **美观配置** - 0.88 透明度，无标题栏
- 💾 **大滚动缓存** - 100 万行历史记录
- 🚀 **快速启动** - 即时显示/隐藏，无动画延迟
- 🤖 **AIChat 快捷入口** - 在当前 kitty 终端底部分屏 TUI 中聊天、解释选区、分析上一条命令输出，兼容 `kitten ssh` 远程会话

## 安装

```bash
./install.sh
```

安装脚本会在覆盖既有配置前生成 `.bak.YYYYMMDDHHMMSS` 备份，并自动安装 GNOME 全局快捷键。

## 快捷键

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+` `` | 呼出/隐藏下拉终端 |
| `Ctrl+上` | 增加窗口高度 |
| `Ctrl+下` | 减少窗口高度 |
| `Ctrl+Alt+方向键` | 在下拉终端中调整分屏窗口大小 |
| `Ctrl+Tab` | 下一个标签 |
| `Ctrl+Shift+Tab` | 上一个标签 |
| `Ctrl+Shift+T` | 新建标签 |
| `Ctrl+Shift+W` | 关闭标签 |
| `Ctrl+Shift+L` | 切换窗口布局 |
| `Ctrl+Shift+Z/X` | 跳转到上一条/下一条命令提示符 |
| `Ctrl+Shift+A` | 回到上次跳转的命令提示符 |
| `Ctrl+Shift+/` | 搜索滚动缓存 |
| `Ctrl+Shift+G` | 查看上一条非空命令输出 |
| `Ctrl+Shift+U` | 查看上次跳转到的命令输出 |
| `Ctrl+Shift+I` | 打开 AIChat TUI 分屏 |
| `Ctrl+Shift+Y` | 用自然语言生成 shell 命令 |
| `Ctrl+Shift+S` | 把选中文本发送给 AIChat |
| `Ctrl+Shift+Alt+S` | 从选中文本生成 shell 命令 |
| `Ctrl+Shift+R` | 把上一条命令输出发送给 AIChat |
| `Ctrl+Shift+K` | 把当前屏幕发送给 AIChat |
| `Ctrl+Shift+M` | 创建屏幕文本标记 |
| `Ctrl+Alt+M` | 移除屏幕文本标记 |
| `Ctrl+Shift+,` | 打开快捷键帮助 |
| `Ctrl+Shift+F1` / `Ctrl+F13` | 打开快捷键帮助（兼容部分键盘的功能键编码） |

## 配置文件说明

- `config/kitty.conf` - 全局快捷键配置
- `config/dropdown.conf` - 下拉窗口主配置
- `bin/kitty-quick-access-toggle` - 窗口切换脚本
- `bin/kitty-quick-access-resize-height` - 高度调整脚本
- `bin/kitty-quick-access-new-tab` - 复用现有下拉终端新建标签
- `bin/kitty-shortcuts-help` - 快捷键帮助 overlay
- `bin/kitty-aichat` - AIChat TUI wrapper
- `bin/kitty-aichat-float` - AIChat 置顶浮窗启动器（备用）

## 卸载

```bash
./uninstall.sh
```

卸载脚本只删除本项目管理的 kitty 配置、quick-access 脚本、状态目录和 GNOME 快捷键，不会删除整个 `~/.config/kitty`。

## 更多信息

更新日期: 2026-04-29
