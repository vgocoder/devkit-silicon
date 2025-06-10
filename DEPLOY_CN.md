# DevKit-Silicon 部署说明

**Complete Dev Kit for Apple Silicon**

*一键部署的 Apple Silicon 开发环境*

[中文文档](DEPLOY_CN.md) | [English](DEPLOY.md)

## GitHub 仓库信息

**仓库地址**: https://github.com/vgocoder/devkit-silicon.git  
**仓库名称**: devkit-silicon  
**主要分支**: main

## 快速使用

### 一键安装（推荐）

```bash
# 完整安装所有工具和配置
bash <(curl -fsSL https://raw.githubusercontent.com/vgocoder/devkit-silicon/main/scripts/install.sh)
```

### 使用 chezmoi

```bash
# 仅应用配置文件（不安装软件）
chezmoi init --apply https://github.com/vgocoder/devkit-silicon.git
```

### 快速开始

```bash
# 安装核心工具
bash <(curl -fsSL https://raw.githubusercontent.com/vgocoder/devkit-silicon/main/scripts/quick-start.sh)
```

## 本地开发

### 克隆仓库

```bash
# 克隆到本地
git clone https://github.com/vgocoder/devkit-silicon.git
cd devkit-silicon

# 查看项目结构
tree -a -I '.git'
```

### 测试安装脚本

```bash
# 测试完整安装脚本
./scripts/install.sh

# 测试快速安装脚本
./scripts/quick-start.sh

# 使用本地配置初始化 chezmoi
chezmoi init --apply .
```

### 推送更新

```bash
# 添加更改
git add .
git commit -m "Update configurations"

# 推送到远程仓库
git push origin main
```

## 团队使用

### 自定义团队配置

1. **Fork 本仓库**到团队组织账号
2. **修改配置文件**适应团队需求
3. **更新脚本中的仓库地址**
4. **团队成员使用统一命令安装**

```bash
# 团队成员安装命令
DOTFILES_REPO="https://github.com/your-team/dotfiles.git" \
bash <(curl -fsSL https://raw.githubusercontent.com/vgocoder/devkit-silicon/main/scripts/install.sh)
```

### 配置文件管理

```bash
# 添加新配置
chezmoi add ~/.config/new-tool/config.yml

# 编辑现有配置
chezmoi edit ~/.zshrc

# 查看配置差异
chezmoi diff

# 应用配置更改
chezmoi apply

# 推送配置到仓库
chezmoi git add .
chezmoi git commit -m "Add new tool configuration"
chezmoi git push
```

## 安装方式对比

| 安装方式 | 适用场景 | 安装内容 | 命令 |
|---------|---------|---------|------|
| **完整安装** | 新机器首次配置 | 所有软件 + 配置文件 | `bash <(curl -fsSL https://raw.githubusercontent.com/vgocoder/devkit-silicon/main/scripts/install.sh)` |
| **仅配置文件** | 已有软件，仅需配置 | 配置文件 | `chezmoi init --apply https://github.com/vgocoder/devkit-silicon.git` |
| **快速开始** | 核心工具快速安装 | 核心工具 + 配置 | `bash <(curl -fsSL https://raw.githubusercontent.com/vgocoder/devkit-silicon/main/scripts/quick-start.sh)` |
| **团队自定义** | 团队统一配置 | 自定义内容 | `DOTFILES_REPO="团队仓库" bash <(curl ...)` |

## 配置文件说明

### 核心配置文件
- **`.chezmoi.toml.tmpl`**: chezmoi 配置模板
- **`dot_zshrc`**: Zsh shell 配置
- **`dot_tmux.conf`**: tmux 会话管理配置
- **`dot_gitconfig`**: Git 工作流配置
- **`Brewfile`**: Homebrew 软件包列表

### 应用配置
- **`dot_config/starship.toml`**: Starship 提示符配置
- **`.mise.toml`**: mise 版本管理配置

### 脚本文件
- **`scripts/install.sh`**: 完整安装脚本
- **`scripts/quick-start.sh`**: 快速开始脚本

## 故障排除

### 常见问题

1. **网络连接问题**
   ```bash
   # 使用代理或镜像源
   export HOMEBREW_INSTALL_FROM_API=1
   export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
   ```

2. **权限问题**
   ```bash
   # 确保脚本有执行权限
   chmod +x scripts/*.sh
   ```

3. **chezmoi 冲突**
   ```bash
   # 备份现有配置后重新初始化
   chezmoi archive
   chezmoi init --force https://github.com/vgocoder/devkit-silicon.git
   ```

## 更新和维护

### 定期更新
```bash
# 更新 chezmoi 管理的配置
chezmoi update

# 更新 Homebrew 软件包
brew update && brew upgrade

# 更新 AI 模型
ollama pull phi3:mini
```

### 备份配置
```bash
# 创建配置备份
chezmoi archive --output backup-$(date +%Y%m%d).tar.gz

# 导出 Brewfile
brew bundle dump --force
```

---

**Apple Silicon 特别优化** 🚀  
所有工具都是 ARM64 原生版本，性能最佳！