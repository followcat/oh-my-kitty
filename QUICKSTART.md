# 快速参考

## 安装

```bash
cd ~/Projects/oh-my-followcat-kitty
./install.sh
```

安装时会备份被替换的 `kitty.conf` / `dropdown.conf`，备份文件会保存在原目录旁边。

## 快捷键速查表

```
╔════════════════════╦════════════════════════════════════╗
║ 快捷键              ║ 功能                               ║
╠════════════════════╬════════════════════════════════════╣
║ Ctrl+`             ║ 呼出/隐藏下拉终端                   ║
║ Ctrl+↑/↓           ║ 增加/减少窗口高度                   ║
║ Ctrl+←/→           ║ 调整内部窗口宽度                    ║
║ Ctrl+Alt+方向键    ║ 下拉终端中调整分屏窗口大小          ║
║ Ctrl+Shift+T       ║ 新建标签                            ║
║ Ctrl+Shift+W       ║ 关闭标签                            ║
║ Ctrl+Tab           ║ 下一个标签                          ║
║ Ctrl+Shift+Tab     ║ 上一个标签                          ║
║ Ctrl+F1-F10        ║ 跳转到标签 1-10                     ║
║ Ctrl+=/-/0         ║ 增大/减小/重置字体大小              ║
║ Ctrl+Shift+H       ║ 显示滚动缓存                        ║
║ Ctrl+Shift+/       ║ 搜索滚动缓存                        ║
║ Ctrl+Shift+G       ║ 查看上一条非空命令输出              ║
║ Ctrl+Shift+U       ║ 查看上次跳转到的命令输出            ║
║ Ctrl+Shift+Z/X     ║ 跳转上一条/下一条命令提示符         ║
║ Ctrl+Shift+A       ║ 回到上次跳转的命令提示符            ║
║ Ctrl+Shift+L       ║ 切换窗口布局                        ║
║ Ctrl+Shift+M       ║ 创建屏幕文本标记                    ║
║ Ctrl+Alt+M         ║ 移除屏幕文本标记                    ║
║ Ctrl+Shift+F1      ║ 打开快捷键帮助                      ║
║ Ctrl+Shift+V       ║ 从剪贴板粘贴                        ║
║ Ctrl+Shift+C       ║ 复制到剪贴板                        ║
╚════════════════════╩════════════════════════════════════╝
```

## 配置文件位置

- `~/.config/kitty/kitty.conf` - 主配置
- `~/.config/kitty/dropdown.conf` - 下拉窗口配置

## 常见问题

### Q: 如何修改默认高度?
A: 编辑 `~/.local/bin/kitty-quick-access-toggle`，改 `DEFAULT_HEIGHT` 值

### Q: 如何修改透明度?
A: 编辑 `~/.config/kitty/dropdown.conf`，改 `background_opacity` 值

### Q: Ctrl+` 没反应?
A: 确保窗口有焦点，或者运行 `~/.local/bin/kitty-quick-access-toggle` 手动启动

### Q: 标题栏还在?
A: 运行 `gsettings set org.gnome.desktop.interface enable-animations false` 禁用 GNOME 动画

## 项目结构

```
oh-my-followcat-kitty/
├── README.md                           # 项目说明
├── install.sh                          # 安装脚本
├── config/
│   ├── kitty.conf                     # 全局配置
│   ├── dropdown.conf                  # 下拉窗口配置
├── bin/
│   ├── kitty-quick-access-toggle      # 窗口切换脚本
│   ├── kitty-quick-access-resize-height # 高度调整脚本
│   ├── kitty-quick-access-new-tab     # 现有下拉终端中新建标签
│   └── kitty-shortcuts-help           # 快捷键帮助
└── docs/
    └── CONFIGURATION.md               # 详细配置文档
```

## 版本信息

- Kitty 版本: 0.46.2+
- 最后更新: 2026-04-29
- 兼容性: GNOME + X11
