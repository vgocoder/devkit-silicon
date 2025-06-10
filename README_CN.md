# DevKit-Silicon

**Complete Dev Kit for Apple Silicon**

*一键部署的 Apple Silicon 开发环境*

**适用场景**: Kubernetes 运维开发 | PHP/Go/Node.js 全栈 | 大数据可视化  
**技术栈**: K8s + Docker + MySQL + Redis + ClickHouse

[中文文档](README_CN.md) | [English](README.md)

## 快速开始

### 一键安装（推荐）

```bash
# 使用本仓库的配置
bash <(curl -fsSL https://raw.githubusercontent.com/vgocoder/devkit-silicon/main/scripts/install.sh)

# 或者使用 chezmoi 直接应用
chezmoi init --apply https://github.com/vgocoder/devkit-silicon.git
```

### 团队协作安装

```bash
# 团队成员使用统一配置
DOTFILES_REPO="https://github.com/your-team/dotfiles.git" \
bash <(curl -fsSL https://raw.githubusercontent.com/vgocoder/devkit-silicon/main/scripts/install.sh)

# 或者
chezmoi init --apply https://github.com/your-team/dotfiles.git
```

## 设计理念

### 核心原则
- **渐进增强**: 现代工具提升体验，传统工具保证兼容
- **双编辑器策略**: AI辅助 + 极速编辑的完美组合
- **跨平台一致**: macOS开发，Linux部署，配置统一
- **工具互补**: 避免功能重复，专注各自优势

## 包含的配置文件

### Shell 配置
- **`.zshrc`**: 现代CLI工具别名、环境变量、历史记录优化
- **`.tmux.conf`**: tmux会话管理配置
- **`.gitconfig`**: Git工作流优化配置

### 应用配置
- **`starship.toml`**: 现代提示符配置
- **`Brewfile`**: 所有软件包依赖管理

## 工具选型

### 终端环境
```
Ghostty          # GPU加速终端
Starship         # 现代提示符
tmux             # 会话管理
```

### 现代CLI工具
```
ripgrep (rg)     # 极速搜索，替代grep
fd               # 智能查找，替代find
bat              # 语法高亮，替代cat
eza              # 现代列表，替代ls
bottom (btm)     # 系统监控，替代top
dust             # 磁盘分析，替代du
procs            # 进程查看，替代ps
```

### 编辑器组合
```
Trae             # 字节跳动AI编辑器，专注AI辅助开发
Zed              # Rust超快编辑器，日常编码首选
```

### 开发工具链
```
mise             # 多语言版本管理
direnv           # 项目环境变量
chezmoi          # 配置文件同步
git + tig        # 版本控制
```

### 容器和K8s
```
OrbStack         # Apple Silicon优化容器运行时
kubectl          # K8s命令行
k9s              # K8s可视化管理
```

### 数据库工具
```
# 图形界面
Sequel Ace       # MySQL专用客户端
DBeaver          # 通用数据库工具
ClickHouse       # ClickHouse图形客户端

# 命令行
mysql-client     # MySQL CLI
redis-cli        # Redis CLI
```

### AI工具
```
# 本地AI
ollama           # 轻量模型运行时
phi3:mini        # 代码生成模型
aichat           # 命令行AI助手

# 云端AI
Trae内置AI       # 强大的编程助手
```

### 效率工具
```
Raycast          # 现代启动器
Rectangle        # 窗口管理
Stats            # 系统状态监控
Obsidian         # 知识管理
Apifox           # API测试
```

## 手动安装

### 1. 安装依赖

```bash
# 安装 Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 安装 chezmoi
brew install chezmoi

# 使用 Brewfile 安装所有软件
brew bundle install
```

### 2. 应用配置

```bash
# 克隆仓库
git clone https://github.com/vgocoder/devkit-silicon.git ~/.local/share/chezmoi

# 应用配置
chezmoi apply

# 或者直接初始化
chezmoi init --apply https://github.com/vgocoder/devkit-silicon.git
```

### 3. 安装AI模型

```bash
# 安装Python AI工具
pip3 install aichat

# 下载AI模型
ollama pull phi3:mini
ollama pull qwen2:1.5b
```

## 工作流程

### 日常开发
```bash
# 项目开发
code .              # 快速编辑用Zed
code --ai .         # AI辅助用Trae

# 系统监控
btm                 # 现代系统监控
k9s                 # K8s集群管理

# 搜索查找
rg "pattern"        # 代码搜索
fd "filename"       # 文件查找
```

### 编辑器分工
**Trae使用场景**:
- 新功能开发和代码生成
- 复杂算法实现
- 代码重构优化
- 技术问题解答

**Zed使用场景**:
- 日常代码编辑
- 快速文件浏览
- Git操作
- 配置文件修改

### 数据库操作
```bash
# MySQL
mysql -u root -p     # 命令行连接
open -a "Sequel Ace" # 图形界面

# Redis
redis-cli           # 命令行操作

# ClickHouse
ch                  # 智能别名（图形界面或命令行）
clickhouse          # 打开图形界面
```

### 服务器运维
```bash
# 远程连接
ssh user@server
tmux new -s work    # 创建工作会话

# 容器管理
d ps                # 查看容器
dc up -d            # 启动服务

# K8s操作
k get pods          # 查看pods
k logs -f pod-name  # 查看日志
```

## 自定义配置

### 个人信息配置

首次运行时，chezmoi 会提示输入个人信息：
- 姓名
- 邮箱地址
- GitHub 用户名

这些信息会自动填入 Git 配置和其他需要的地方。

### 添加新配置

```bash
# 添加新的配置文件到 chezmoi 管理
chezmoi add ~/.config/new-app/config.yml

# 编辑配置文件
chezmoi edit ~/.zshrc

# 应用更改
chezmoi apply
```

### 团队配置同步

```bash
# 推送配置更改
chezmoi git add .
chezmoi git commit -m "Update configuration"
chezmoi git push

# 拉取团队配置更新
chezmoi update
```

## 验证安装

```bash
# 核心工具验证
starship --version && echo "✅ 提示符"
rg --version && echo "✅ 搜索工具"
zed --version && echo "✅ 编辑器"
kubectl version --client && echo "✅ K8s工具"

# 数据库工具验证
mysql --version && echo "✅ MySQL客户端"
redis-cli --version && echo "✅ Redis客户端"
ls /Applications/ClickHouse.app >/dev/null 2>&1 && echo "✅ ClickHouse图形客户端" || echo "❌ ClickHouse未安装"

# AI工具验证
ollama list && echo "✅ AI模型"
aichat --version && echo "✅ AI助手"
```

## 故障排除

### 常见问题

1. **Homebrew 安装失败**
   ```bash
   # 检查网络连接，使用国内镜像
   export HOMEBREW_INSTALL_FROM_API=1
   export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
   ```

2. **chezmoi 配置冲突**
   ```bash
   # 备份现有配置
   chezmoi archive
   
   # 重新初始化
   chezmoi init --force
   ```

3. **AI模型下载慢**
   ```bash
   # 使用代理或稍后重试
   ollama pull phi3:mini
   ```

## 贡献指南

1. Fork 本仓库
2. 创建功能分支: `git checkout -b feature/new-config`
3. 提交更改: `git commit -am 'Add new configuration'`
4. 推送分支: `git push origin feature/new-config`
5. 提交 Pull Request

## 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

## 致谢

感谢所有开源项目的贡献者，特别是：
- [chezmoi](https://chezmoi.io/) - 配置文件管理
- [Starship](https://starship.rs/) - 现代提示符
- [Homebrew](https://brew.sh/) - macOS 包管理器

---

**Apple Silicon 特别优化** 🚀  
所有工具都是 ARM64 原生版本，性能最佳！