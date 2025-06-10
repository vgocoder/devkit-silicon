#!/bin/bash
# 快速开始脚本 - 仅安装核心工具
set -e

echo "🚀 快速安装核心开发工具..."

# 检查并安装 Homebrew
if ! command -v brew &> /dev/null; then
    echo "📦 安装 Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 安装 chezmoi
if ! command -v chezmoi &> /dev/null; then
    echo "📁 安装 chezmoi..."
    brew install chezmoi
fi

# 应用配置
echo "⚙️ 应用 dotfiles 配置..."
if [ -n "$1" ]; then
    # 使用提供的仓库URL
    chezmoi init --apply "$1"
else
    # 使用当前目录
    chezmoi init --apply "$(pwd)"
fi

echo "✅ 核心配置已应用！"
echo "💡 运行完整安装: bash <(curl -fsSL https://raw.githubusercontent.com/vgocoder/devkit-silicon/main/scripts/install.sh)"
echo "🔧 重新加载配置: source ~/.zshrc"