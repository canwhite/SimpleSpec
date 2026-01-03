# SimpleSpec - Claude Code 配置文件自动化安装包

> 🚀 一键安装 Claude Code 配置文件到任何项目
>
> **版本**: v1.0.0 | **最后更新**: 2026-01-03

## 📦 项目简介

SimpleSpec 是一个 Claude Code 配置文件自动化安装包，旨在简化 Claude Code 配置在不同项目间的部署和管理。通过单条命令即可在任何项目中安装标准化的 Claude Code 配置。

### 核心特性

- 🚀 **一键安装**: 单条命令完成所有配置安装
- 💾 **自动备份**: 安装前自动备份现有配置
- 🔄 **版本管理**: 支持安装特定版本的配置
- ↩️ **回滚机制**: 支持一键回滚到之前版本
- 📊 **批量部署**: 支持在多个项目中批量安装
- 🛡️ **安全可靠**: 失败自动回滚，内容验证

## 📦 包含文件

| 文件 | 说明 |
|------|------|
| `.claudecode.json` | Claude Code 自定义指令配置 |
| `CLAUDE.md` | 全感知任务管理模式协议文档（v2.0） |
| `install.sh` | 自动化安装脚本 |
| `production.md` | 项目全局状态文档 |

## 🎯 快速开始

### 方式1: 远程一键安装（推荐）

在任何项目中执行：

```bash
# 使用 curl
curl -fsSL https://raw.githubusercontent.com/yourusername/SimpleSpec/main/install.sh | bash

# 使用 wget
wget -qO- https://raw.githubusercontent.com/yourusername/SimpleSpec/main/install.sh | bash
```

### 方式2: 本地安装

```bash
# 克隆仓库
git clone https://github.com/yourusername/SimpleSpec.git
cd SimpleSpec

# 执行安装
bash install.sh install
```

### 方式3: 手动安装

```bash
# 下载配置文件
curl -O https://raw.githubusercontent.com/yourusername/SimpleSpec/main/.claudecode.json
curl -O https://raw.githubusercontent.com/yourusername/SimpleSpec/main/CLAUDE.md

# 创建schema目录
mkdir -p schema/archive
```

## 🔧 脚本功能

### 安装功能
- ✅ 自动备份现有配置
- ✅ 下载最新配置文件
- ✅ 创建必要的目录结构
- ✅ 失败自动回滚

### 管理功能
```bash
# 查看所有备份
bash install.sh backups

# 回滚到最近的备份
bash install.sh rollback

# 清理30天前的旧备份
bash install.sh clean

# 查看帮助
bash install.sh help
```

## 📁 安装后的目录结构

```
your-project/
├── .claudecode.json          # Claude Code 配置
├── CLAUDE.md                  # 任务管理协议
├── schema/                    # 任务文档目录
│   ├── archive/               # 已归档任务
│   └── task_*.md             # 进行中的任务
└── .claude-code-backup/      # 备份目录（自动创建）
    ├── .claudecode.json.20260103_120000
    ├── CLAUDE.md.20260103_120000
    └── schema.20260103_120000
```

## ⚙️ 配置说明

### .claudecode.json

定义 Claude Code 的行为模式：

```json
{
  "version": "2.0",
  "customInstructions": [
    "遵循 'CLAUDE.md' 中的全感知任务管理模式 v2.0。",
    "核心原则1：收到 'START:' 指令时，必须先检查production.md...",
    "核心原则2：收到 'START:' 指令后，必须创建 schema/task_*.md..."
  ],
  "notAllowedPatterns": [
    "在收到 'START:' 没有检查production.md就执行后续操作",
    "在收到 'START:' 指令后未创建 'schema/task_*.md' 就开始执行代码"
  ]
}
```

### CLAUDE.md

定义详细的任务管理协议，包括：
- 全局认知初始化
- 任务启动流程
- 动态上下文刷新
- 任务结项流程
- 错误恢复机制

## 🔄 备份和恢复

### 自动备份

每次安装前自动备份现有配置：
```bash
.claude-code-backup/
├── .claudecode.json.20260103_120000
├── CLAUDE.md.20260103_120000
└── schema.20260103_120000
```

### 手动回滚

```bash
# 回滚到最近的备份
bash install.sh rollback

# 或手动恢复
cp .claude-code-backup/.claudecode.json.20260103_120000 .claudecode.json
cp .claude-code-backup/CLAUDE.md.20260103_120000 CLAUDE.md
```

## 🛠️ 自定义配置

### 修改远程仓库URL

编辑 `install.sh` 中的 `REPO_URL`：

```bash
REPO_URL="https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main"
```

### 修改配置文件

1. Fork 本仓库
2. 修改 `.claudecode.json` 和 `CLAUDE.md`
3. 更新 install.sh 中的 REPO_URL 指向你的仓库
4. 使用你自己的安装命令

## 📊 版本管理

### 查看当前版本

```bash
grep "SCRIPT_VERSION" install.sh
# 输出: SCRIPT_VERSION="1.0.0"
```

### 更新到最新版本

```bash
# 重新运行安装脚本
curl -fsSL https://raw.githubusercontent.com/yourusername/claude-code-config/main/install.sh | bash
```

## 🌟 使用示例

### 在新项目中使用

```bash
cd /path/to/your/project
curl -fsSL https://raw.githubusercontent.com/yourusername/claude-code-config/main/install.sh | bash

# 配置已安装，现在可以使用：
# START: 分析代码架构
```

### 批量安装到多个项目

```bash
#!/bin/bash
PROJECTS=("/path/to/project1" "/path/to/project2" "/path/to/project3")

for project in "${PROJECTS[@]}"; do
  echo "安装到 $project"
  cd "$project"
  curl -fsSL https://raw.githubusercontent.com/yourusername/claude-code-config/main/install.sh | bash
done
```

### 集成到项目初始化脚本

```bash
#!/bin/bash
# init-project.sh

echo "初始化项目..."

# 你的其他初始化步骤...

# 安装 Claude Code 配置
echo "安装 Claude Code 配置..."
curl -fsSL https://raw.githubusercontent.com/yourusername/claude-code-config/main/install.sh | bash

echo "项目初始化完成！"
```

## 🔍 故障排查

### 问题1: 安装失败

**症状**: 脚本执行出错

**解决方案**:
```bash
# 检查网络连接
ping raw.githubusercontent.com

# 手动下载测试
curl -I https://raw.githubusercontent.com/yourusername/claude-code-config/main/.claudecode.json

# 查看详细日志
bash -x install.sh install
```

### 问题2: 权限错误

**症状**: Permission denied

**解决方案**:
```bash
# 添加执行权限
chmod +x install.sh

# 或使用bash直接执行
bash install.sh install
```

### 问题3: 配置文件已存在

**症状**: 担心覆盖现有配置

**解决方案**:
```bash
# 脚本会自动备份，无需担心
# 安装前查看备份
bash install.sh backups

# 如需回滚
bash install.sh rollback
```

## 📝 更新日志

### v1.0.0 (2026-01-03)
- ✨ 初始版本
- ✅ 支持自动化安装
- ✅ 支持备份和回滚
- ✅ 支持远程安装
- ✅ 支持本地安装

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License

## 🔗 相关链接

- [Claude Code 官方文档](https://docs.anthropic.com)
- [项目仓库](https://github.com/yourusername/claude-code-config)

## 💡 提示

1. **首次使用**: 建议先在测试项目中试用
2. **定期更新**: 定期运行安装脚本获取最新配置
3. **自定义配置**: Fork 仓库并修改配置以适应你的需求
4. **版本控制**: 将 `.claudecode.json` 和 `CLAUDE.md` 提交到项目仓库

---

**作者**: Claude Code Assistant
**版本**: 1.0.0
**最后更新**: 2026-01-03
