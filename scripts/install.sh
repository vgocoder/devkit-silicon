#!/bin/bash
set -e

echo "🚀 开始安装 Apple Silicon 开发环境..."

# 检查系统架构
if [[ $(uname -m) != "arm64" ]]; then
    echo "⚠️ 此脚本专为 Apple Silicon 设计，当前系统可能不兼容"
    read -p "是否继续？(y/N): " confirm
    [[ $confirm != "y" && $confirm != "Y" ]] && exit 1
fi

# 获取系统信息
CHIP_INFO=$(system_profiler SPHardwareDataType | grep "Chip:" | awk '{print $2, $3}')
echo "🔍 检测到芯片: $CHIP_INFO"

# 安装 Homebrew
if ! command -v brew &> /dev/null; then
    echo "📦 安装 Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "📦 更新 Homebrew..."
brew update

# 安装终端工具
echo "📱 安装终端环境..."
brew install --cask ghostty
brew install starship tmux

# 安装现代CLI工具
echo "🔧 安装现代CLI工具..."
brew install ripgrep fd bat eza dust procs htop tig
brew tap clementtsang/bottom && brew install bottom

# 安装开发工具
echo "💻 安装开发工具..."
brew install mise direnv chezmoi jq yq git

# 安装编辑器
echo "📝 安装编辑器..."
brew install --cask trae zed

# 安装容器运行时
echo "🐳 安装容器运行时..."
brew install --cask orbstack

# 安装Kubernetes工具
echo "☸️ 安装Kubernetes工具..."
brew install kubectl k9s

# 安装数据库工具
echo "🗄️ 安装数据库工具..."
brew install --cask sequel-ace dbeaver-community
brew install mysql-client redis
if command -v clickhouse-client >/dev/null 2>&1; then
    echo "    ClickHouse 客户端已安装"
else
    echo "    安装 ClickHouse 图形界面客户端..."
    brew install --cask clickhouse
fi

# 安装AI工具
echo "🤖 安装AI工具..."
brew install ollama
if ! command -v pip3 &> /dev/null; then
    brew install python@3.12
fi
pip3 install aichat

# 安装系统效率工具
echo "⚡ 安装效率工具..."
brew install --cask raycast rectangle stats

# 安装知识管理和API工具
echo "📚 安装工作流工具..."
brew install --cask obsidian apifox

# 下载AI模型（后台执行）
echo "🧠 下载AI模型..."
ollama pull phi3:mini &
ollama pull qwen2:1.5b &

# 安装 chezmoi 并应用配置
echo "📁 安装并配置 dotfiles..."
if ! command -v chezmoi &> /dev/null; then
    brew install chezmoi
fi

# 如果提供了 dotfiles 仓库 URL，则使用它
if [ -n "$DOTFILES_REPO" ]; then
    echo "📥 从 $DOTFILES_REPO 应用配置..."
    chezmoi init --apply "$DOTFILES_REPO"
else
    echo "📥 初始化本地配置..."
    chezmoi init
    
    # 如果是从本地运行，复制配置文件到 chezmoi 管理
    if [ -f "$(dirname "$0")/../dot_zshrc" ]; then
        cp "$(dirname "$0")/../dot_zshrc" "$(chezmoi source-path)/dot_zshrc"
    fi
    if [ -f "$(dirname "$0")/../dot_tmux.conf" ]; then
        cp "$(dirname "$0")/../dot_tmux.conf" "$(chezmoi source-path)/dot_tmux.conf"
    fi
    if [ -f "$(dirname "$0")/../dot_gitconfig" ]; then
        cp "$(dirname "$0")/../dot_gitconfig" "$(chezmoi source-path)/dot_gitconfig"
    fi
    if [ -d "$(dirname "$0")/../dot_config" ]; then
        cp -r "$(dirname "$0")/../dot_config" "$(chezmoi source-path)/"
    else
        # 如果本地文件不存在，从 GitHub 仓库初始化
        chezmoi init --apply https://github.com/vgocoder/devkit-silicon.git
    fi
    
    chezmoi apply
fi

# 等待AI模型下载完成
echo "⏳ 等待AI模型下载完成..."
wait

# 创建常用目录
echo "📂 创建常用目录..."
mkdir -p ~/Projects ~/Scripts ~/Documents/Notes

echo "✅ Apple Silicon 开发环境安装配置完成！"
echo ""
echo "🔍 系统信息: $CHIP_INFO"
echo ""
echo "📋 已安装的核心软件："
echo "   🖥️  终端: Ghostty"
echo "   🐳 容器: OrbStack (Apple Silicon 优化)"
echo "   📝 编辑器: Trae + Zed"
echo "   ☸️  K8s: kubectl + k9s"
echo "   🗄️  数据库: Sequel Ace + DBeaver + ClickHouse"
echo "   🤖 AI: Ollama + aichat"
echo "   ⚡ 效率: Raycast + Rectangle + Stats"
echo ""
echo "🚀 下一步操作："
echo "1. 重启终端或执行: source ~/.zshrc"
echo "2. 启动Ghostty作为默认终端"
echo "3. 启动OrbStack进行容器开发"
echo "4. 测试编辑器: code . 或 code --ai ."
echo "5. 测试AI: chat '你好' 或 ai '帮我写个函数'"
echo ""
echo "🔧 验证安装："
echo "   starship --version"
echo "   zed --version"
echo "   kubectl version --client"
echo "   ollama list"
echo ""
echo "💡 Apple Silicon 特别提示："
echo "   - 已设置 DOCKER_DEFAULT_PLATFORM=linux/amd64"
echo "   - OrbStack 已针对 Apple Silicon 优化"
echo "   - 所有工具都是 ARM64 原生版本"
echo "   - ClickHouse 使用图形界面客户端"