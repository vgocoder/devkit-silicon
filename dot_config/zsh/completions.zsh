#!/usr/bin/env zsh
# ============================================================================
# Zsh 自动补全增强配置
# DevKit-Silicon - 专业的终端自动补全体验
# ============================================================================

# 基础补全系统初始化
autoload -Uz compinit
# 检查补全缓存，24小时内不重复检查
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# 加载必要的模块
zmodload zsh/complist

# ============================================================================
# 补全样式和行为配置
# ============================================================================

# 补全菜单样式
zstyle ':completion:*' menu select=2
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

# 颜色配置
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# 大小写不敏感匹配
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

# 补全缓存
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# 错误容忍
zstyle ':completion:*' max-errors 1 numeric

# ============================================================================
# 特定命令补全优化
# ============================================================================

# 进程补全（kill, killall 等）
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always

# SSH/SCP/RSYNC 主机补全
zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' users admin root
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# Git 补全优化
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:git-*:*' group-order 'main commands' 'alias commands' 'external commands'
zstyle ':completion:*:git-add:*' ignored-patterns '*.orig'

# Docker 补全优化
zstyle ':completion:*:docker:*' option-stacking yes
zstyle ':completion:*:docker-*:*' option-stacking yes

# 文件补全优化
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' file-sort modification
zstyle ':completion:*:*:cp:*' file-sort size
zstyle ':completion:*:*:scp:*' file-sort size

# 目录补全优化
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'

# ============================================================================
# 现代工具补全集成
# ============================================================================

# Kubernetes (kubectl) 补全
if command -v kubectl >/dev/null 2>&1; then
    source <(kubectl completion zsh)
fi

# Docker 补全
if command -v docker >/dev/null 2>&1; then
    # Docker 补全通常由系统包提供
    if [[ -f /opt/homebrew/etc/bash_completion.d/docker ]]; then
        source /opt/homebrew/etc/bash_completion.d/docker
    fi
fi

# Docker Compose 补全
if command -v docker-compose >/dev/null 2>&1; then
    if [[ -f /opt/homebrew/etc/bash_completion.d/docker-compose ]]; then
        source /opt/homebrew/etc/bash_completion.d/docker-compose
    fi
fi

# Helm 补全
if command -v helm >/dev/null 2>&1; then
    source <(helm completion zsh)
fi

# GitHub CLI 补全
if command -v gh >/dev/null 2>&1; then
    eval "$(gh completion -s zsh)"
fi

# Terraform 补全
if command -v terraform >/dev/null 2>&1; then
    autoload -U +X bashcompinit && bashcompinit
    complete -o nospace -C terraform terraform
fi

# AWS CLI 补全
if command -v aws >/dev/null 2>&1; then
    autoload -U +X bashcompinit && bashcompinit
    complete -C aws_completer aws
fi

# Homebrew 补全
if command -v brew >/dev/null 2>&1; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# ============================================================================
# 自定义补全函数
# ============================================================================

# 智能 cd 补全（仅显示目录）
_smart_cd() {
    _path_files -/
}
compdef _smart_cd cd

# 增强的文件编辑器补全
_editor_files() {
    _files -g "*.(#i)(txt|md|py|js|ts|go|rs|java|c|cpp|h|hpp|sh|zsh|bash|yml|yaml|json|xml|html|css|scss|sass|vue|jsx|tsx)"
}
compdef _editor_files code
compdef _editor_files zed
compdef _editor_files vim
compdef _editor_files nvim

# Git 别名补全映射
compdef gs=git
compdef gl=git
compdef ga=git
compdef gc=git
compdef gp=git
compdef gpl=git
compdef gco=git
compdef gb=git
compdef gd=git
compdef gst=git

# Kubernetes 别名补全映射
compdef k=kubectl
compdef kgp=kubectl
compdef kgs=kubectl
compdef kgd=kubectl
compdef kge=kubectl
compdef kdp=kubectl
compdef kds=kubectl
compdef kdd=kubectl

# Docker 别名补全映射
compdef d=docker
compdef dc=docker-compose
compdef dps=docker
compdef di=docker
compdef drm=docker
compdef drmi=docker

# ============================================================================
# 补全行为选项
# ============================================================================

# 自动补全选项
setopt AUTO_MENU              # 自动使用菜单补全
setopt COMPLETE_IN_WORD       # 在单词中间也可以补全
setopt ALWAYS_TO_END          # 补全后光标移到末尾
setopt AUTO_LIST              # 自动列出选择
setopt AUTO_PARAM_SLASH       # 目录参数自动添加斜杠
setopt COMPLETE_ALIASES       # 补全别名
setopt LIST_PACKED            # 紧凑显示补全列表
setopt LIST_ROWS_FIRST        # 按行优先显示补全

# 禁用的选项
unsetopt MENU_COMPLETE        # 不要自动选择第一个补全
unsetopt FLOW_CONTROL         # 禁用流控制（Ctrl+S/Ctrl+Q）

# ============================================================================
# 补全快捷键绑定
# ============================================================================

# Tab 和 Shift+Tab 补全导航
bindkey '^I' expand-or-complete-prefix    # Tab: 智能补全
bindkey '^[[Z' reverse-menu-complete      # Shift+Tab: 反向补全

# 补全菜单导航
bindkey -M menuselect '^[[A' up-line-or-history      # 上箭头
bindkey -M menuselect '^[[B' down-line-or-history    # 下箭头
bindkey -M menuselect '^[[C' forward-char             # 右箭头
bindkey -M menuselect '^[[D' backward-char            # 左箭头

# 补全菜单中的其他快捷键
bindkey -M menuselect '^M' accept-line                # Enter: 接受选择
bindkey -M menuselect '^[' send-break                 # Esc: 取消补全
bindkey -M menuselect '^[[3~' delete-char             # Delete: 删除字符

# ============================================================================
# 补全性能优化
# ============================================================================

# 限制补全结果数量以提高性能
zstyle ':completion:*' max-matches-width 80
zstyle ':completion:*' max-matches 100

# 跳过某些大型目录的补全
zstyle ':completion:*' ignored-patterns '*/Cache/*' '*/cache/*' '*/tmp/*' '*/.git/*' '*/node_modules/*' '*/.DS_Store'

# 优化路径补全
zstyle ':completion:*' path-completion true
zstyle ':completion:*' special-dirs true

echo "✅ Zsh 自动补全系统已加载完成"