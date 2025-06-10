#!/usr/bin/env zsh
# ============================================================================
# Zsh 自动补全增强配置
# DevKit-Silicon - 专业的终端自动补全体验
# ============================================================================

# 基础补全系统初始化
autoload -Uz compinit

# 跳过安全检查以避免权限警告
compinit -u

# 加载补全系统的其他模块
autoload -Uz bashcompinit && bashcompinit

# 加载必要的模块
zmodload zsh/complist

# 确保 menuselect keymap 可用
if [[ -z "$terminfo[smkx]" ]] || [[ -z "$terminfo[rmkx]" ]]; then
    function zle-line-init() {
        echoti smkx
    }
    function zle-line-finish() {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# ============================================================================
# 补全样式和行为配置
# ============================================================================

# 补全菜单样式
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# 补全分组和描述
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'

# 补全排序
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history

# 进程补全
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:*:killall:*' force-list always

# ============================================================================
# 特定命令补全优化
# ============================================================================

# SSH/SCP/RSYNC 主机补全
zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# Git 补全
zstyle ':completion:*:*:git:*' tag-order 'common-commands'
zstyle ':completion:*:*:git*:*' group-order 'main commands' 'alias commands' 'external commands'

# Docker 补全
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# 文件和目录补全优化
zstyle ':completion:*' squeeze-slashes true
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

# Docker Compose 补全 - 修复版本
if command -v docker-compose >/dev/null 2>&1; then
    # 尝试加载 bash 补全文件
    if [[ -f /opt/homebrew/etc/bash_completion.d/docker-compose ]]; then
        source /opt/homebrew/etc/bash_completion.d/docker-compose
    fi
    # 如果没有找到补全文件，创建基础补全
    if ! type _docker-compose >/dev/null 2>&1; then
        _docker-compose() {
            local context state line
            _arguments -C \
                '1: :->commands' \
                '*: :->args'
            case $state in
                commands)
                    _values 'docker-compose commands' \
                        'build[Build or rebuild services]' \
                        'up[Create and start containers]' \
                        'down[Stop and remove containers]' \
                        'start[Start services]' \
                        'stop[Stop services]' \
                        'restart[Restart services]' \
                        'logs[View output from containers]' \
                        'ps[List containers]' \
                        'exec[Execute a command in a running container]'
                    ;;
            esac
        }
        compdef _docker-compose docker-compose
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
    autoload bashcompinit && bashcompinit
    complete -C aws_completer aws
fi

# Homebrew 补全
if command -v brew >/dev/null 2>&1; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# ============================================================================
# 自定义补全函数
# ============================================================================

# 为常用别名创建补全映射
if alias g >/dev/null 2>&1; then
    compdef g=git
fi

if alias k >/dev/null 2>&1; then
    compdef k=kubectl
fi

if alias d >/dev/null 2>&1; then
    compdef d=docker
fi

if alias dc >/dev/null 2>&1; then
    compdef dc=docker-compose
fi

# ============================================================================
# 补全行为选项
# ============================================================================

# 自动补全选项
setopt AUTO_LIST
setopt AUTO_MENU
setopt AUTO_PARAM_SLASH
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt GLOB_COMPLETE
setopt HASH_LIST_ALL
setopt LIST_AMBIGUOUS
setopt LIST_BEEP

# 补全忽略选项
setopt NO_CASE_GLOB
setopt NO_NOMATCH

# ============================================================================
# 补全快捷键绑定
# ============================================================================

# 在补全菜单中使用方向键
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# 在补全菜单中使用 Ctrl 键
bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey -M menuselect '^M' accept-line

# ============================================================================
# 补全性能优化
# ============================================================================

# 缓存设置
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache

# 限制补全结果数量以提高性能
zstyle ':completion:*' max-errors 2
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:default' menu 'select=0'

# 补全延迟设置
zstyle ':completion:*' delay 0.1

# 完成加载提示
echo "✅ Zsh 自动补全系统已加载完成"