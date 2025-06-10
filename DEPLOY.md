# DevKit-Silicon Deployment Guide

**Complete Dev Kit for Apple Silicon**

*一键部署的 Apple Silicon 开发环境*

[中文文档](DEPLOY_CN.md) | [English](DEPLOY.md)

## GitHub Repository Information

**Repository URL**: https://github.com/vgocoder/devkit-silicon.git  
**Repository Name**: devkit-silicon  
**Main Branch**: main

## Quick Usage

### One-Click Installation (Recommended)

```bash
# Complete installation of all tools and configurations
bash <(curl -fsSL https://raw.githubusercontent.com/vgocoder/devkit-silicon/main/scripts/install.sh)
```

### Using chezmoi

```bash
# Apply configuration files only (no software installation)
chezmoi init --apply https://github.com/vgocoder/devkit-silicon.git
```

### Quick Start

```bash
# Install core tools
bash <(curl -fsSL https://raw.githubusercontent.com/vgocoder/devkit-silicon/main/scripts/quick-start.sh)
```

## Local Development

### Clone Repository

```bash
# Clone to local
git clone https://github.com/vgocoder/devkit-silicon.git
cd devkit-silicon

# View project structure
tree -a -I '.git'
```

### Test Installation Scripts

```bash
# Test complete installation script
./scripts/install.sh

# Test quick installation script
./scripts/quick-start.sh

# Initialize chezmoi with local configuration
chezmoi init --apply .
```

### Push Updates

```bash
# Add changes
git add .
git commit -m "Update configurations"

# Push to remote repository
git push origin main
```

## Team Usage

### Custom Team Configuration

1. **Fork this repository** to your team organization account
2. **Modify configuration files** to suit team needs
3. **Update repository URLs in scripts**
4. **Team members use unified installation command**

```bash
# Team member installation command
DOTFILES_REPO="https://github.com/your-team/dotfiles.git" \
bash <(curl -fsSL https://raw.githubusercontent.com/vgocoder/devkit-silicon/main/scripts/install.sh)
```

### Configuration File Management

```bash
# Add new configuration
chezmoi add ~/.config/new-tool/config.yml

# Edit existing configuration
chezmoi edit ~/.zshrc

# View configuration differences
chezmoi diff

# Apply configuration changes
chezmoi apply

# Push configuration to repository
chezmoi git add .
chezmoi git commit -m "Add new tool configuration"
chezmoi git push
```