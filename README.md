# DevKit-Silicon

**Complete Dev Kit for Apple Silicon**

*一键部署的 Apple Silicon 开发环境*

**Use Cases**: Kubernetes Operations | PHP/Go/Node.js Full-Stack | Big Data Visualization  
**Tech Stack**: K8s + Docker + MySQL + Redis + ClickHouse

[中文文档](README_CN.md) | [English](README.md)

## ✨ Features

- **🚀 One-Click Setup**: Complete development environment with a single command
- **🛠️ Modern Tools**: Latest CLI tools and utilities for Apple Silicon
- **⚙️ Smart Configuration**: Optimized dotfiles for productivity
- **🔧 Development Ready**: Pre-configured for multiple programming languages
- **📦 Package Management**: Automated dependency installation
- **🎨 Beautiful Terminal**: Enhanced shell experience with themes and plugins
- **⌨️ Smart Completion**: Advanced auto-completion for commands, files, and modern tools

### ⌨️ Smart Completion System
- **Advanced Completion Engine**: Powerful Zsh-based completion system
- **Modern Tool Integration**: Native completion for kubectl, Docker, Helm, GitHub CLI, Terraform, and more
- **Intelligent Matching**: Supports fuzzy matching, case-insensitive, and partial matching
- **Context Awareness**: Provides relevant completion options based on command context
- **Performance Optimized**: Completion caching and lazy loading for fast response
- **Custom Completions**: Completion support for common aliases and custom commands

## Quick Start

### One-Click Installation (Recommended)

```bash
# Use this repository configuration
bash <(curl -fsSL https://raw.githubusercontent.com/vgocoder/devkit-silicon/main/scripts/install.sh)

# Or use chezmoi directly
chezmoi init --apply https://github.com/vgocoder/devkit-silicon.git
```

### Team Collaboration

```bash
# Team members use unified configuration
DOTFILES_REPO="https://github.com/your-team/dotfiles.git" \
bash <(curl -fsSL https://raw.githubusercontent.com/vgocoder/devkit-silicon/main/scripts/install.sh)

# Or
chezmoi init --apply https://github.com/your-team/dotfiles.git
```

## Design Philosophy

### Core Principles
- **Progressive Enhancement**: Modern tools improve experience, traditional tools ensure compatibility
- **Dual Editor Strategy**: Perfect combination of AI assistance + ultra-fast editing
- **Cross-Platform Consistency**: Develop on macOS, deploy on Linux, unified configuration
- **Tool Complementarity**: Avoid feature duplication, focus on respective advantages

## Configuration Files

### Shell Configuration
- **`.zshrc`**: Modern CLI tool aliases, environment variables, history optimization
- **`.tmux.conf`**: tmux session management configuration
- **`.gitconfig`**: Git workflow optimization configuration

### Application Configuration
- **`starship.toml`**: Modern prompt configuration
- **`Brewfile`**: All software package dependency management

## Tool Selection

### Terminal Environment
```
Ghostty          # GPU-accelerated terminal
Starship         # Modern prompt
tmux             # Session management
```

### Modern CLI Tools
```
ripgrep (rg)     # Ultra-fast search, replaces grep
fd               # Smart find, replaces find
bat              # Syntax highlighting, replaces cat
eza              # Modern listing, replaces ls
bottom (btm)     # System monitoring, replaces top
dust             # Disk analysis, replaces du
procs            # Process viewer, replaces ps
```

### Editor Combination
```
Trae             # ByteDance AI editor, focused on AI-assisted development
Zed              # Rust ultra-fast editor, daily coding preference
```

### Development Toolchain
```
mise             # Multi-language version management
direnv           # Project environment variables
chezmoi          # Configuration file synchronization
git + tig        # Version control
```

### Container and K8s
```
OrbStack         # Apple Silicon optimized container runtime
kubectl          # K8s command line
k9s              # K8s visual management
```

### Database Tools
```
# GUI
Sequel Ace       # MySQL dedicated client
DBeaver          # Universal database tool
ClickHouse       # ClickHouse GUI client

# CLI
mysql-client     # MySQL CLI
redis-cli        # Redis CLI
```

### AI Tools
```
# Local AI
ollama           # Lightweight model runtime
phi3:mini        # Code generation model
aichat           # Command line AI assistant

# Cloud AI
Trae Built-in AI # Powerful programming assistant
```

### Productivity Tools
```
Raycast          # Modern launcher
Rectangle        # Window management
Stats            # System status monitoring
Obsidian         # Knowledge management
Apifox           # API testing
```

## Manual Installation

### 1. Install Dependencies

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install chezmoi
brew install chezmoi

# Install all software using Brewfile
brew bundle install
```

### 2. Apply Configuration

```bash
# Clone repository
git clone https://github.com/vgocoder/devkit-silicon.git ~/.local/share/chezmoi

# Apply configuration
chezmoi apply

# Or initialize directly
chezmoi init --apply https://github.com/vgocoder/devkit-silicon.git
```

### 3. Install AI Models

```bash
# Install Python AI tools
pip3 install aichat

# Download AI models
ollama pull phi3:mini
ollama pull qwen2:1.5b
```

## Workflow

### Daily Development
```bash
# Project development
code .              # Fast editing with Zed
code --ai .         # AI assistance with Trae

# System monitoring
btm                 # Modern system monitoring
k9s                 # K8s cluster management

# Search and find
rg "pattern"        # Code search
fd "filename"       # File find
```

### Editor Division
**Trae Use Cases**:
- New feature development and code generation
- Complex algorithm implementation
- Code refactoring optimization
- Technical problem solving

**Zed Use Cases**:
- Daily code editing
- Quick file browsing
- Git operations
- Configuration file modification

### Database Operations
```bash
# MySQL
mysql -u root -p     # Command line connection
open -a "Sequel Ace" # GUI

# Redis
redis-cli           # Command line operations

# ClickHouse
ch                  # Smart alias (GUI or CLI)
clickhouse          # Open GUI
```

### Server Operations
```bash
# Remote connection
ssh user@server
tmux new -s work    # Create work session

# Container management
d ps                # View containers
dc up -d            # Start services

# K8s operations
k get pods          # View pods
k logs -f pod-name  # View logs
```

## Custom Configuration

### Personal Information Setup

On first run, chezmoi will prompt for personal information:
- Name
- Email address
- GitHub username

This information will be automatically filled into Git configuration and other required places.

### Adding New Configuration

```bash
# Add new configuration file to chezmoi management
chezmoi add ~/.config/new-app/config.yml

# Edit configuration file
chezmoi edit ~/.zshrc

# Apply changes
chezmoi apply
```

### Team Configuration Sync

```bash
# Push configuration changes
chezmoi git add .
chezmoi git commit -m "Update configuration"
chezmoi git push

# Pull team configuration updates
chezmoi update
```

## Installation Verification

```bash
# Core tool verification
starship --version && echo "✅ Prompt"
rg --version && echo "✅ Search tool"
zed --version && echo "✅ Editor"
kubectl version --client && echo "✅ K8s tool"

# Database tool verification
mysql --version && echo "✅ MySQL client"
redis-cli --version && echo "✅ Redis client"
ls /Applications/ClickHouse.app >/dev/null 2>&1 && echo "✅ ClickHouse GUI client" || echo "❌ ClickHouse not installed"

# AI tool verification
ollama list && echo "✅ AI models"
aichat --version && echo "✅ AI assistant"
```

## Troubleshooting

### Common Issues

1. **Homebrew Installation Failed**
   ```bash
   # Check network connection, use domestic mirror
   export HOMEBREW_INSTALL_FROM_API=1
   export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
   ```

2. **chezmoi Configuration Conflict**
   ```bash
   # Backup existing configuration
   chezmoi archive
   
   # Reinitialize
   chezmoi init --force
   ```

3. **AI Model Download Slow**
   ```bash
   # Use proxy or retry later
   ollama pull phi3:mini
   ```

## Contributing

1. Fork this repository
2. Create feature branch: `git checkout -b feature/new-config`
3. Commit changes: `git commit -am 'Add new configuration'`
4. Push branch: `git push origin feature/new-config`
5. Submit Pull Request

## License

MIT License - See [LICENSE](LICENSE) file for details

## Acknowledgments

Thanks to all open source project contributors, especially:
- [chezmoi](https://chezmoi.io/) - Configuration file management
- [Starship](https://starship.rs/) - Modern prompt
- [Homebrew](https://brew.sh/) - macOS package manager

---

**Apple Silicon Specially Optimized** 🚀  
All tools are ARM64 native versions for best performance!
