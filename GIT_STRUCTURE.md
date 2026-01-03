# Git 仓库结构示例

## 仓库结构

```
claude-code-config/              # 仓库名
├── .claudecode.json             # Claude Code 配置文件
├── CLAUDE.md                     # 任务管理协议
├── install.sh                    # 安装脚本
├── README.md                     # 说明文档
├── GIT_STRUCTURE.md              # 本文件
└── examples/                     # 示例目录
    ├── quick-start.sh            # 快速开始示例
    ├── batch-install.sh          # 批量安装示例
    └── custom-config/            # 自定义配置示例
        ├── .claudecode.json      # 自定义配置示例
        └── CLAUDE.md             # 自定义协议示例
```

## GitHub 仓库设置

### 1. 创建新仓库

```bash
# 在GitHub上创建新仓库: claude-code-config
# 然后执行:

git clone https://github.com/yourusername/claude-code-config.git
cd claude-code-config

# 复制配置文件
cp /path/to/dujiaoka/.claudecode.json .
cp /path/to/dujiaoka/CLAUDE.md .
cp /path/to/dujiaoka/tools/claude-code-installer/install.sh .
cp /path/to/dujiaoka/tools/claude-code-installer/README.md .

# 提交到仓库
git add .
git commit -m "Initial commit: Claude Code configuration files"
git push origin main
```

### 2. 配置仓库URL

修改 `install.sh` 中的 REPO_URL：

```bash
# 原始
REPO_URL="https://raw.githubusercontent.com/yourusername/claude-code-config/main"

# 修改为你的仓库URL
REPO_URL="https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main"
```

### 3. 测试远程安装

```bash
# 在任何新项目中测试
cd /tmp/test-project
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/install.sh | bash
```

## Git 仓库最佳实践

### 分支策略

```
main (生产版本)
├── stable/1.0 (稳定版本)
└── dev (开发版本)
```

### 发布流程

1. **开发**: 在 `dev` 分支修改配置
2. **测试**: 在测试项目中验证
3. **发布**: 合并到 `main` 分支
4. **标签**: 创建版本标签 `v1.0.0`

```bash
# 创建版本标签
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

### 版本化安装

```bash
# 安装特定版本
REPO_URL="https://raw.githubusercontent.com/yourusername/claude-code-config/v1.0.0"
curl -fsSL "${REPO_URL}/install.sh" | bash
```

## GitHub Actions 自动化

### 自动更新检测

创建 `.github/workflows/check-update.yml`：

```yaml
name: Check for Updates

on:
  schedule:
    - cron: '0 0 * * *'  # 每天检查
  workflow_dispatch:

jobs:
  check-update:
    runs-on: ubuntu-latest
    steps:
      - name: Check version
        run: |
          echo "Checking for configuration updates..."
          # 添加版本检查逻辑
```

### 自动发布

创建 `.github/workflows/release.yml`：

```yaml
name: Create Release

on:
  push:
    tags:
      - 'v*'

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Create Release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          tag_name: ${{ github.ref }}
          release_name: Release ${{ github.ref }}
          draft: false
          prerelease: false
```

## 配置文件管理

### .gitignore

```gitignore
# 备份文件
.claude-code-backup/

# 任务文档（可选，根据需求）
# schema/

# 临时文件
*.tmp
.DS_Store
```

### 配置文件版本管理

```bash
# 查看配置历史
git log -- .claudecode.json
git log -- CLAUDE.md

# 对比版本差异
git diff v1.0.0 v1.1.0 -- .claudecode.json

# 回滚到特定版本
git checkout v1.0.0 -- .claudecode.json CLAUDE.md
```

## 多环境配置

### 开发环境

```bash
# 开发环境配置
REPO_URL="https://raw.githubusercontent.com/yourusername/claude-code-config/dev"
curl -fsSL "${REPO_URL}/install.sh" | bash
```

### 生产环境

```bash
# 生产环境配置
REPO_URL="https://raw.githubusercontent.com/yourusername/claude-code-config/main"
curl -fsSL "${REPO_URL}/install.sh" | bash
```

## 团队协作

### Fork 工作流

1. **Fork 主仓库**到你的账号
2. **克隆 Fork**的仓库
3. **修改配置**以适应团队需求
4. **提交修改**到你的仓库
5. **更新 REPO_URL** 指向你的 Fork

### 组织仓库

```bash
# 创建组织仓库
https://github.com/YOUR_ORG/claude-code-config

# 团队成员使用
REPO_URL="https://raw.githubusercontent.com/YOUR_ORG/claude-code-config/main"
curl -fsSL "${REPO_URL}/install.sh" | bash
```

## 安全考虑

### 私有仓库

```bash
# 如果是私有仓库，需要认证
curl -u USERNAME:TOKEN \
  -fsSL https://raw.githubusercontent.com/username/repo/main/install.sh | bash
```

### 敏感信息

- ❌ 不要在配置文件中包含API密钥
- ❌ 不要包含硬编码的密码
- ✅ 使用环境变量
- ✅ 使用配置文件分离

## 监控和统计

### 使用统计

```bash
# 在 install.sh 中添加统计
STATS_URL="https://your-analytics.com/install"
curl -s -X POST "${STATS_URL}" \
  -d "version=${SCRIPT_VERSION}" \
  -d "timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
```

### 错误报告

```bash
# 错误日志上报
log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
    # 上报错误
    curl -s -X POST "https://your-analytics.com/error" \
      -d "error=$1" \
      -d "script_version=${SCRIPT_VERSION}"
}
```

## 维护计划

### 定期维护任务

- [ ] 每月检查配置文件是否需要更新
- [ ] 每季度审查文档准确性
- [ ] 根据Claude Code更新调整配置
- [ ] 收集用户反馈并改进

### 更新检查清单

- [ ] 测试安装脚本
- [ ] 验证配置文件语法
- [ ] 更新版本号
- [ ] 更新文档
- [ ] 创建Git标签
- [ ] 发布Release

---

**最后更新**: 2026-01-03
**维护者**: Your Name
