# SimpleSpec - Claude Code 配置文件自动化安装包

> **最后更新**: 2026-01-03
> **版本**: v1.0.0
> **维护者**: Claude Code Assistant

---

## 📋 项目定位

SimpleSpec 是一个 Claude Code 配置文件自动化安装包，旨在简化 Claude Code 配置在不同项目间的部署和管理。

### 核心功能
- ✅ 一键安装：通过单条命令在任意项目中安装 Claude Code 配置
- ✅ 自动备份：安装前自动备份现有配置
- ✅ 版本管理：支持安装特定版本的配置
- ✅ 回滚机制：支持一键回滚到之前的配置版本
- ✅ 批量部署：支持在多个项目中批量安装配置

---

## 🏗️ 核心架构

### 项目结构

```
SimpleSpec/
├── .claudecode.json         # Claude Code 配置文件
├── CLAUDE.md                 # 任务管理协议文档
├── install.sh                # 主安装脚本
├── README.md                 # 使用文档
├── GIT_STRUCTURE.md          # Git仓库管理指南
├── production.md             # 项目全局状态（本文件）
├── examples/                 # 示例脚本
│   ├── quick-start.sh       # 快速开始演示
│   └── batch-install.sh     # 批量安装示例
└── schema/                   # 任务文档目录
    ├── archive/             # 已归档任务
    └── task_*.md            # 进行中的任务
```

### 工作流程

```
1. 用户执行安装命令
   curl -fsSL https://raw.githubusercontent.com/user/SimpleSpec/main/install.sh | bash
   ↓
2. install.sh 脚本执行
   - 检查依赖（curl/wget）
   - 备份现有配置
   - 下载配置文件
   - 创建目录结构
   ↓
3. 配置文件安装到项目
   - .claudecode.json
   - CLAUDE.md
   - schema/archive/
   ↓
4. 用户开始使用 Claude Code
   - START: 指令创建任务文档
   - 自动遵循任务管理协议
```

---

## 🛠️ 技术栈

### 脚本语言
- **Bash Shell**: 主要安装脚本语言
- **ShellCheck**: Bash脚本静态分析工具

### 核心工具
- **curl/wget**: 下载配置文件
- **git**: 版本控制
- **GitHub**: 远程仓库托管

### 支持平台
- ✅ Linux (Ubuntu, CentOS, Debian, etc.)
- ✅ macOS
- ✅ Windows (WSL)

---

## 📁 目录结构说明

### 根目录文件

| 文件 | 说明 | 作用 |
|------|------|------|
| `.claudecode.json` | Claude Code配置 | 定义AI助手的执行协议 |
| `CLAUDE.md` | 任务管理协议 | 详细的任务管理流程规范 |
| `install.sh` | 安装脚本 | 自动化安装主脚本 |
| `README.md` | 使用文档 | 用户使用指南 |
| `GIT_STRUCTURE.md` | Git指南 | Git仓库管理说明 |
| `production.md` | 项目状态 | 项目全局认知文档 |

### examples/ 目录

包含使用示例脚本：
- `quick-start.sh`: 交互式快速开始演示
- `batch-install.sh`: 批量安装示例

### schema/ 目录

Claude Code 任务文档存储：
- `archive/`: 已完成的任务归档
- `task_*.md`: 进行中的任务文档

---

## ⚙️ 部署流程

### 方式1: 远程一键安装（推荐）

在任何项目中执行：

```bash
curl -fsSL https://raw.githubusercontent.com/yourusername/SimpleSpec/main/install.sh | bash
```

### 方式2: 本地安装

```bash
git clone https://github.com/yourusername/SimpleSpec.git
cd SimpleSpec
bash install.sh install
```

### 方式3: Fork并自定义

```bash
# 1. Fork SimpleSpec 仓库
# 2. 克隆你的 Fork
git clone https://github.com/YOUR_USERNAME/SimpleSpec.git

# 3. 修改配置文件
# 编辑 .claudecode.json 和 CLAUDE.md

# 4. 使用你的版本
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/SimpleSpec/main/install.sh | bash
```

---

## 🎯 关键特性

### 1. 配置管理

**.claudecode.json** 包含：
- 自定义指令列表
- 禁止行为模式
- 任务初始化命令

**CLAUDE.md** 包含：
- 全感知任务管理模式 v2.0
- 任务启动流程
- 动态上下文刷新
- 错误恢复机制

### 2. 自动化安装

**install.sh** 提供：
- 依赖检查（curl/wget）
- 自动备份机制
- 失败自动回滚
- 多种管理命令

**可用命令**：
```bash
bash install.sh install     # 安装配置
bash install.sh rollback    # 回滚配置
bash install.sh backups     # 查看备份
bash install.sh clean       # 清理旧备份
bash install.sh help        # 显示帮助
```

### 3. 备份策略

每次安装前自动备份：
```
.claude-code-backup/
├── .claudecode.json.YYYYMMDD_HHMMSS
├── CLAUDE.md.YYYYMMDD_HHMMSS
└── schema.YYYYMMDD_HHMMSS
```

### 4. 版本管理

支持安装特定版本：
```bash
curl -fsSL https://raw.githubusercontent.com/user/SimpleSpec/v1.0.0/install.sh | bash
```

---

## 🔄 维护流程

### 定期维护任务

1. **每月检查**:
   - 检查配置文件是否需要更新
   - 审查文档准确性
   - 收集用户反馈

2. **版本发布**:
   - 创建版本标签 `git tag -a v1.0.0`
   - 更新 README.md 版本号
   - 发布 GitHub Release

3. **文档更新**:
   - 更新 production.md
   - 更新使用示例
   - 补充故障排查方法

### 更新检查清单

- [ ] 测试安装脚本
- [ ] 验证配置文件语法
- [ ] 更新版本号
- [ ] 更新文档
- [ ] 创建Git标签
- [ ] 发布Release

---

## 📊 使用统计

### 目标用户

- 开发者：在项目中使用 Claude Code
- 团队：统一团队的任务管理规范
- 组织：定制化的 Claude Code 配置

### 使用场景

1. **新项目初始化**
   ```bash
   mkdir new-project
   cd new-project
   curl -fsSL https://raw.githubusercontent.com/user/SimpleSpec/main/install.sh | bash
   ```

2. **批量部署**
   ```bash
   bash examples/batch-install.sh
   ```

3. **CI/CD集成**
   ```yaml
   - name: Install Claude Code Config
     run: curl -fsSL https://raw.githubusercontent.com/user/SimpleSpec/main/install.sh | bash
   ```

---

## 🔑 关键配置

### .claudecode.json

```json
{
  "version": "2.0",
  "customInstructions": [
    "遵循 'CLAUDE.md' 中的全感知任务管理模式 v2.0。",
    "核心原则：收到 START: 指令时，必须先检查是否有production.md..."
  ],
  "notAllowedPatterns": [
    "在收到 'START:' 没有检查production.md就执行后续操作"
  ],
  "tasks": {
    "initialize": {
      "description": "初始化项目状态和全局认知",
      "command": "ls -R && cat production.md"
    }
  }
}
```

### CLAUDE.md

定义详细的任务管理协议，包括：
- 全局认知初始化
- 任务启动流程
- 动态上下文刷新
- 任务结项流程
- 错误恢复机制

---

## 🚀 快速开始

### 1. 安装到项目

```bash
cd /path/to/your/project
curl -fsSL https://raw.githubusercontent.com/yourusername/SimpleSpec/main/install.sh | bash
```

### 2. 开始使用

```bash
# 在 Claude Code 中
START: 分析项目架构

# AI会自动：
# 1. 检查production.md
# 2. 创建schema/task_*.md
# 3. 开始执行任务
```

### 3. 查看备份

```bash
bash /path/to/install.sh backups
```

---

## 🛡️ 安全建议

1. **私有仓库**: 使用 GitHub Token 访问私有仓库
2. **内容验证**: 脚本自动验证下载的文件
3. **自动备份**: 安装前自动备份，避免数据丢失
4. **版本锁定**: 生产环境使用固定版本标签

---

## 📞 故障排查

### 常见问题

**Q: 安装失败怎么办？**
- 检查网络连接
- 验证仓库URL是否正确
- 查看脚本日志：`bash -x install.sh install`

**Q: 如何回滚配置？**
- 执行：`bash install.sh rollback`
- 或手动恢复备份目录中的文件

**Q: 如何自定义配置？**
- Fork 仓库
- 修改 `.claudecode.json` 和 `CLAUDE.md`
- 使用你的 Fork URL

---

## 📝 更新日志

### v1.0.0 (2026-01-03)
- ✨ 初始版本发布
- ✅ 支持一键安装
- ✅ 自动备份和回滚
- ✅ 版本管理
- ✅ 批量安装支持

---

## 📚 相关文档

### 项目文档
- `README.md` - 用户使用指南
- `GIT_STRUCTURE.md` - Git仓库管理
- `CLAUDE.md` - 任务管理协议

### 外部文档
- [Claude Code 官方文档](https://docs.anthropic.com)
- [Bash 脚本最佳实践](https://github.com/bminor/bash-style-guide)

---

## 🔗 相关链接

- **GitHub仓库**: https://github.com/yourusername/SimpleSpec
- **问题反馈**: https://github.com/yourusername/SimpleSpec/issues
- **更新日志**: https://github.com/yourusername/SimpleSpec/blob/main/CHANGELOG.md

---

**维护记录**:
- 2026-01-03: 创建 SimpleSpec 项目
- 2026-01-03: 完成安装脚本和文档
- 2026-01-03: 创建 production.md
- 2026-01-03: 修改 install.sh 的 REPO_URL 为 canwhite/SimpleSpec
- 2026-01-03: 优化 README.md 的 Context Engineering 部分，增强结构和实用性
- 2026-01-03: 归档已完成任务 task_apply_config 和 task_check_requirements
- 2026-01-04: 创建 install.sh 实现机制详解文档 (schema/install_sh_implementation_guide.md)
- 2026-01-04: 归档已完成任务 task_explain_install_260104_142217
- 2026-01-04: 归档已完成任务 task_fix_context_eng_260103_213055
