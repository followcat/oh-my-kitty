# Oh My FollowCat Kitty 🐱

一个优雅的 Kitty 终端配置，包含 Guake 风格的下拉窗口功能。

## 功能特点

- 🎯 **Guake 风格下拉终端** - 按 `Ctrl+` `` 快速呼出/隐藏
- ⌨️ **快捷键控制** - `Ctrl+上/下` 调整窗口高度
- 🎨 **美观配置** - 0.88 透明度，无标题栏
- 💾 **大滚动缓存** - 100 万行历史记录
- 🚀 **快速启动** - 即时显示/隐藏，无动画延迟

## 安装

```bash
./install.sh
```

## 快捷键

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+` `` | 呼出/隐藏下拉终端 |
| `Ctrl+上` | 增加窗口高度 |
| `Ctrl+下` | 减少窗口高度 |
| `Ctrl+Tab` | 下一个标签 |
| `Ctrl+Shift+Tab` | 上一个标签 |
| `Ctrl+Shift+T` | 新建标签 |
| `Ctrl+Shift+W` | 关闭标签 |

## 配置文件说明

- `config/kitty.conf` - 全局快捷键配置
- `config/dropdown.conf` - 下拉窗口主配置
- `bin/kitty-quick-access-toggle` - 窗口切换脚本
- `bin/kitty-quick-access-resize-height` - 高度调整脚本
- `bin/kitty-quick-access-new-tab` - 复用现有下拉终端新建标签

## 卸载

```bash
rm -rf ~/.config/kitty
rm -f ~/.local/bin/kitty-quick-access-*
rm -rf ~/.local/state/kitty-quick-access
```

## 更多信息

更新日期: 2026-04-29
