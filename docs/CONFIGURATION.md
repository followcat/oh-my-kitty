# Kitty 配置详解

## 主要配置文件

### kitty.conf - 全局配置
- 窗口快捷键（Ctrl+上下左右调整窗口大小）
- 标签管理快捷键（Ctrl+Tab 等）
- Shell integration 和命令提示符跳转
- tall/fat/grid/stack/splits 布局切换
- 滚动缓存搜索和屏幕文本标记
- 字体设置（Agave Nerd Font 14pt）
- 颜色主题

### dropdown.conf - 下拉窗口配置
- 透明度：0.88（88% 不透明）
- 滚动缓存：1,000,000 行
- 无标题栏和边框
- 字体和颜色与主配置一致
- 自定义快捷键（Ctrl+上下调整高度）
- 与普通 kitty 一致的布局、滚动缓存、命令输出浏览快捷键
- `Ctrl+Alt+方向键` 调整下拉终端中的分屏窗口大小
- AIChat TUI 分屏快捷键，支持选区、上一条命令输出和当前屏幕输入

## 脚本文件

### kitty-quick-access-toggle
Guake 风格下拉窗口切换脚本：
- 第一次按 Ctrl+` 显示窗口
- 第二次按 Ctrl+` 最小化窗口
- 默认高度为 820px，最大高度可调到屏幕可用高度
- 状态保存在 `~/.local/state/kitty-quick-access/`

### kitty-quick-access-resize-height
调整下拉窗口高度：
- 接受参数：+40 或 -40（像素）
- 保存高度状态用于下次启动
- 默认最大高度为屏幕可用高度
- 由 Ctrl+上/下 快捷键触发

### kitty-quick-access-new-tab
复用当前下拉终端实例：
- 如果下拉终端已存在，则直接新建标签
- 如果下拉终端不存在，则先拉起窗口再新建标签

### kitty-aichat
AIChat TUI wrapper：
- `Ctrl+Shift+I`：直接打开 AIChat REPL
- `Ctrl+Shift+Y`：输入自然语言需求，生成 shell 命令后可粘贴或执行到源窗口
- `Ctrl+Shift+S`：把当前选区通过 stdin 发送给 AIChat
- `Ctrl+Shift+Alt+S`：把当前选区作为 shell 需求，生成命令后可粘贴或执行到源窗口
- `Ctrl+Shift+R`：把上一条命令输出通过 stdin 发送给 AIChat
- `Ctrl+Shift+K`：把当前屏幕通过 stdin 发送给 AIChat

### kitty-aichat-float
AIChat 置顶浮窗启动器，作为备用入口保留。它会启动一个独立的小 kitty 窗口，默认尺寸为 `760x520`，放在屏幕右上方并设置 `_NET_WM_STATE_ABOVE`。再次触发快捷键时，如果浮窗已经存在，会直接聚焦已有窗口。

默认快捷键使用 kitty 内部分屏 TUI，不启动独立 OS 窗口，并固定从本机 `HOME` 启动，不跟随当前窗口 cwd。这样在 `kitten ssh` 进入远端目录后，快捷键仍然调用本机的 `aichat`，不会因为远端 cwd 在本机不存在而启动失败。

启动 AIChat 分屏时会记录源窗口 ID。命令生成类快捷键会在 AIChat 分屏中生成候选命令，再选择粘贴或执行到源窗口；选区、上一条输出和当前屏幕分析类快捷键仍以源窗口内容作为上下文。

可通过环境变量调整位置和尺寸：
- `KITTY_AICHAT_FLOAT_WIDTH`
- `KITTY_AICHAT_FLOAT_HEIGHT`
- `KITTY_AICHAT_FLOAT_TOP`
- `KITTY_AICHAT_FLOAT_RIGHT_GAP`

没有默认绑定完整 scrollback，因为本配置保留 1,000,000 行历史，一键发送完整 scrollback 容易产生很大的模型输入。

## 关键特性

### Shell integration
显式启用 kitty shell integration：
```
shell_integration enabled
```

常用快捷键：
- `Ctrl+Shift+Z`：跳到上一条命令提示符
- `Ctrl+Shift+X`：跳到下一条命令提示符
- `Ctrl+Shift+A`：回到上次跳转的位置
- `Ctrl+Shift+G`：查看上一条非空命令输出
- `Ctrl+Shift+U`：查看上次跳转到的命令输出

### 布局管理
启用常用布局：
```
enabled_layouts tall,fat,grid,stack,splits
map ctrl+shift+l next_layout
```

### 滚动缓存和标记
- `Ctrl+Shift+/`：搜索滚动缓存
- `Ctrl+Shift+H`：在 pager 中查看完整滚动缓存
- `Ctrl+Shift+M`：创建文本标记
- `Ctrl+Alt+M`：移除文本标记

### 快捷键帮助
`Ctrl+Shift+F1` 会打开一个 kitty overlay，显示当前项目维护的快捷键速查表：
```
map ctrl+shift+f1 launch --type=overlay @HOME@/.local/bin/kitty-shortcuts-help
```

### 无装饰窗口
使用 MOTIF hints 移除 GNOME 标题栏：
```
_MOTIF_WM_HINTS "2, 0, 0, 0, 0"
```

### 快速启动
- 禁用 GNOME 动画
- 使用 xdotool 直接操作窗口
- 无应用内动画

### 高效历史
- 1,000,000 行滚动缓存
- 支持 Ctrl+Shift+H 显示历史

## 自定义

### 修改透明度
编辑 `config/dropdown.conf`：
```
background_opacity 0.88  # 改成 0.5 到 1.0 之间的值
```

### 修改快捷键
编辑 `config/dropdown.conf` 或 `config/kitty.conf`，修改 `map` 行：
```
map ctrl+up launch --type=background @HOME@/.local/bin/kitty-quick-access-resize-height 40
```

`@HOME@` 会在运行 `install.sh` 时替换成当前用户的 home 目录。

### 修改默认高度
编辑 `bin/kitty-quick-access-toggle` 脚本，修改 `DEFAULT_HEIGHT` 或 `MAX_HEIGHT_PERCENT`：
```
DEFAULT_HEIGHT="${KITTY_QUICK_ACCESS_DEFAULT_HEIGHT:-820}"
MAX_HEIGHT_PERCENT="${KITTY_QUICK_ACCESS_MAX_HEIGHT_PERCENT:-100}"
```

## 故障排除

### Ctrl+上下不工作
确保：
1. 在 kitty 下拉窗口中按快捷键（需要窗口焦点）
2. 脚本有执行权限：`chmod +x ~/.local/bin/kitty-quick-access-*`
3. 运行 `install.sh` 重新安装

### 标题栏还存在
这可能是窗口管理器的问题：
1. 确保 GNOME 动画已禁用：`gsettings set org.gnome.desktop.interface enable-animations false`
2. 检查是否使用了其他窗口管理器

### 快捷键显示但窗口不出现
检查 kitty 进程是否正在运行：
```
ps aux | grep kitty-quick-access-guake
```

重新启动：
```
kill <PID>
```

然后按 Ctrl+` 重新启动。
