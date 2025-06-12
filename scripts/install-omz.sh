#!/bin/bash

# ============================================================================
# Oh-My-Zsh 安装脚本
# DevKit-Silicon - 轻量化 oh-my-zsh 安装
# ============================================================================

set -e

echo "🚀 DevKit-Silicon Oh-My-Zsh 安装脚本"
echo "=========================================="

# 检查是否已安装 oh-my-zsh
if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo "✅ Oh-My-Zsh 已安装在 $HOME/.oh-my-zsh"
    echo "ℹ️  如需重新安装，请先删除现有安装：rm -rf ~/.oh-my-zsh"
    exit 0
fi

# 检查是否通过 Homebrew 安装
if command -v brew >/dev/null 2>&1; then
    if [[ -d "/opt/homebrew/share/oh-my-zsh" ]] || [[ -d "/usr/local/share/oh-my-zsh" ]]; then
        echo "✅ Oh-My-Zsh 已通过 Homebrew 安装"
        echo "ℹ️  DevKit 补全系统会自动检测并使用 Homebrew 版本"
        exit 0
    fi
fi

echo "📦 准备安装 Oh-My-Zsh..."
echo ""
echo "选择安装方式："
echo "1) 官方安装脚本（推荐）"
echo "2) Homebrew 安装（轻量化）"
echo "3) 取消安装"
echo ""
read -p "请选择 [1-3]: " choice

case $choice in
    1)
        echo "📥 使用官方安装脚本安装 Oh-My-Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        echo "✅ Oh-My-Zsh 安装完成！"
        ;;
    2)
        if ! command -v brew >/dev/null 2>&1; then
            echo "❌ 未找到 Homebrew，请先安装 Homebrew 或选择官方安装方式"
            exit 1
        fi
        echo "📥 使用 Homebrew 安装 Oh-My-Zsh..."
        brew install oh-my-zsh
        echo "✅ Oh-My-Zsh 通过 Homebrew 安装完成！"
        ;;
    3)
        echo "❌ 安装已取消"
        exit 0
        ;;
    *)
        echo "❌ 无效选择，安装已取消"
        exit 1
        ;;
esac

echo ""
echo "🎉 安装完成！"
echo ""
echo "📝 接下来的步骤："
echo "1. 重新加载 shell：source ~/.zshrc"
echo "2. 或者重新打开终端"
echo "3. DevKit 补全系统会自动检测并集成 Oh-My-Zsh 功能"
echo ""
echo "⚙️  配置选项："
echo "- 编辑 ~/.config/zsh/completions.conf 来自定义补全模块"
echo "- 设置 DEVKIT_ENABLE_OMZ_COMPLETIONS=false 来禁用 Oh-My-Zsh 集成"
echo ""
echo "✨ 享受增强的终端补全体验！"