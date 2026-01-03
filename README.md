# SimpleSpec - Claude Code 配置文件自动化安装包

>  主要是觉得OpenSpec有些时候太硬了，不灵活且不适合自己，所以自己配了context engineering 规则，验证还不错，留做自用；
>
>  当然大家也可以根据需要配置自己的规则

### Pre:
项目中已经安装了claude code

### How to install
```
curl -fsSL https://raw.githubusercontent.com/canwhite/SimpleSpec/main/install.sh | bash
```

### How to use

1. 终端输入claude启用cc
2. START:  输入任务prompt开始任务
   - 此时如果没有全局production会自建，这是项目锚点；
   - 然后task会建在项目schema/文件夹下，e.g. schema/task_apply_config_260103_210524.md，然后任务会自动执行

3. DONE: schema/task_apply_config_260103_210524.md
   - 任务完成之后输入DONE: 任务名，任务就会存档到schema/archive


### Context Engineering

#### 理念说明

SimpleSpec 采用了一套基于**物理文件载体**的 AI 任务管理方法论，通过将 AI 的思考过程外化为可追溯的文档，解决了长上下文场景下的注意力衰减问题。这套方法受到了现代 AI 智能体工程（Agentic Engineering）理念的启发，但更注重实战可用性。

#### 已实现的核心机制

##### 1. Project Memory Index (production.md) - 长期记忆

**作用**：作为项目的"常识库"和全局认知锚点。

**在 SimpleSpec 中的实现**：
- 项目初始化时自动创建或检查 `production.md`
- 包含项目定位、核心架构、技术栈、目录结构等关键信息
- 每次任务启动时首先读取，确保 AI 对项目有全局认知

**示例**：
```bash
# AI 自动执行
ls -R && cat production.md
```

##### 2. Dynamic Contextual Refreshing (末尾重述) - 瞬时注意力

**作用**：对抗长上下文带来的注意力衰减，每次回复末尾强制刷新关键信息。

**在 SimpleSpec 中的实现**：
- 每次回复末尾必须包含任务快照：
```text
[项目全局状态]: 已同步至 production.md
[当前任务文件]: <文件名>
[当前目标]: <一句话目标>
[已完成]: <最近一步>
[下一步]: <下一步>
```

**效果**：确保 AI 始终知道"我是谁、我在哪、我要干什么"。

##### 3. Recursive Task Decomposition (schema/task_*.md) - 递归任务分解

**作用**：将大任务拆解为可管理的小任务，防止"逻辑偏移"。

**在 SimpleSpec 中的实现**：
- 收到 `START:` 指令时，创建 `schema/task_[简码]_[时间戳].md`
- 在任务文档中列出：最终目标、拆解步骤、当前进度
- 使用 TodoWrite 工具创建待办列表，一次只激活一个子任务

**关键规则**：
```
一次只允许激活一个子任务
只有当前子任务完成后，才允许更新状态并锁定下一个子任务
```

**示例**：
```markdown
## 拆解步骤
1. 分析现有代码
   - [ ] 1.1 读取主文件
   - [ ] 1.2 识别关键函数
2. 实现新功能
   - [ ] 2.1 编写核心逻辑
   - [ ] 2.2 添加错误处理
```

#### 可增强的机制

以下机制可以根据实际需要选择性添加：

##### 1. Environment Feedback Loop - 环境反馈循环

**目的**：解决 AI"盲目自信"问题，确保任务真的完成。

**实现建议**：
在 CLAUDE.md 的协议中加入：
```markdown
## 验证机制
- 禁止仅凭直觉更新 [已完成] 状态
- 必须在更新前执行验证命令（如 ls, grep, npm test）
- 必须在任务文档中附上验证结果
```

**示例**：
```markdown
## 当前进度
### 正在进行
正在实现用户认证功能

### 验证结果
```bash
$ npm test
✓ All tests passed
```
```

##### 2. Error Propagation Constraint - 错误传播约束

**目的**：解决"幻觉螺旋"，防止 AI 在错误路径上越走越远。

**实现建议**：
在 CLAUDE.md 中加入"断路器"机制：
```markdown
## 断路器机制
如果 [下一步] 连续 3 次未能改变 [已完成] 的状态：
1. 立即停止当前操作
2. 清空当前瞬时注意力
3. 重新读取 production.md
4. 从头反思任务路径是否正确
```

#### S.P.A.R 框架总结

这套方法论可以归纳为 **S.P.A.R 框架**：

| 维度 | 英文 | 含义 | 在 SimpleSpec 中的体现 |
|------|------|------|----------------------|
| **S** | Stateful | 状态化 | `schema/task_*.md` 让 AI 变成有状态的实例 |
| **P** | Persistent | 持久化 | `production.md` 确保全局认知不丢失 |
| **A** | Anchored | 锚定化 | "末尾重述"将注意力锚定在最近的上下文 |
| **R** | Reflective | 反思化 | 环境反馈循环和错误约束（可选增强） |

**当前状态**：SimpleSpec 已实现 **S、P、A** 三个维度，足以应付 90% 的日常开发任务。

#### 实践建议

1. **先使用，后优化**
   - 用现有配置跑一周，观察实际效果
   - 记录 AI 在哪些任务上容易出错
   - 针对性添加增强机制

2. **不要过度工程化**
   - 当前配置已经形成完整的闭环
   - 除非遇到明确痛点，否则不需要添加更多约束

3. **保持简单**
   - 物理文件载体是最简单可靠的方案
   - 避免引入额外的复杂度（如数据库、外部依赖）

4. **实战验证**
   - 在真实项目中使用
   - 根据实际反馈调整
   - 保持文档和代码同步更新

#### 参考资源

- **本项目的协议文档**：`CLAUDE.md` - 详细的全感知任务管理模式 v2.0
- **任务文档示例**：`schema/task_*.md` - 实际的任务执行记录
- **项目全局状态**：`production.md` - 项目认知锚点
