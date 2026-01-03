#!/bin/bash

#############################################
# 批量安装示例 - 在多个项目中安装配置
#############################################

set -e

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=========================================="
echo "  Claude Code 配置批量安装示例"
echo "=========================================="
echo ""

# 示例1: 从列表文件批量安装
echo "示例1: 从项目列表批量安装"
echo "-----------------------------------"
echo "创建项目列表文件 projects.txt:"
cat << 'EOF'
> /path/to/project1
> /path/to/project2
> /path/to/project3
> EOF
echo ""
echo "运行批量安装:"
echo '  while read project; do'
echo '    echo "安装到: $project"'
echo '    cd "$project"'
echo '    curl -fsSL https://raw.githubusercontent.com/yourusername/claude-code-config/main/install.sh | bash'
echo '    cd -'
echo '  done < projects.txt'
echo ""

# 示例2: 使用数组批量安装
echo "示例2: 使用数组批量安装"
echo "-----------------------------------"
cat << 'BASH_SCRIPT'
#!/bin/bash

PROJECTS=(
  "/Users/developer/project1"
  "/Users/developer/project2"
  "/Users/developer/project3"
)

REPO_URL="https://raw.githubusercontent.com/yourusername/claude-code-config/main"

for project in "${PROJECTS[@]}"; do
  if [ -d "$project" ]; then
    echo -e "${GREEN}安装到: $project${NC}"
    cd "$project"
    curl -fsSL "${REPO_URL}/install.sh" | bash
    echo "✅ 完成"
    echo ""
  else
    echo -e "${YELLOW}⚠️  跳过不存在的目录: $project${NC}"
  fi
done
BASH_SCRIPT
echo ""

# 示例3: 查找所有Git项目并批量安装
echo "示例3: 自动查找Git项目并安装"
echo "-----------------------------------"
cat << 'BASH_SCRIPT'
#!/bin/bash

# 查找所有包含.git目录的项目
find /path/to/projects -maxdepth 2 -name ".git" -type d | while read git_dir; do
  project_dir=$(dirname "$git_dir")
  echo "发现项目: $project_dir"

  cd "$project_dir"
  curl -fsSL https://raw.githubusercontent.com/yourusername/claude-code-config/main/install.sh | bash
  cd -
done
BASH_SCRIPT
echo ""

# 示例4: 交互式批量安装
echo "示例4: 交互式批量安装"
echo "-----------------------------------"
cat << 'BASH_SCRIPT'
#!/bin/bash

echo "请输入项目目录（每行一个，输入空行结束）:"
echo ""

projects=()
while IFS= read -r line; do
  [ -z "$line" ] && break
  projects+=("$line")
done

echo ""
echo "将在以下项目中安装:"
for i in "${!projects[@]}"; do
  echo "  $((i+1)). ${projects[$i]}"
done

read -p "确认安装? (y/n) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
  for project in "${projects[@]}"; do
    if [ -d "$project" ]; then
      echo "安装到: $project"
      cd "$project"
      curl -fsSL https://raw.githubusercontent.com/yourusername/claude-code-config/main/install.sh | bash
    else
      echo "跳过: $project (目录不存在)"
    fi
  done
fi
BASH_SCRIPT
echo ""

# 实际演示
echo "=========================================="
echo "  实际演示"
echo "=========================================="
echo ""

# 创建示例项目
echo "创建3个示例项目..."
PROJECTS=()
for i in {1..3}; do
  project_dir="/tmp/claude-demo-project-$i"
  mkdir -p "$project_dir"
  cd "$project_dir"
  git init
  echo "# Demo Project $i" > README.md
  PROJECTS+=("$project_dir")
  echo "✅ 创建: $project_dir"
done

echo ""
read -p "是否要在这些示例项目中安装配置? (y/n) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
  for project in "${PROJECTS[@]}"; do
    echo ""
    echo -e "${GREEN}安装到: $project${NC}"
    cd "$project"
    curl -fsSL https://raw.githubusercontent.com/yourusername/claude-code-config/main/install.sh | bash || {
      echo "❌ 安装失败（可能是网络问题，这是预期的）"
    }
  done

  echo ""
  echo "✅ 批量安装完成！"
  echo ""
  echo "清理示例项目..."
  for project in "${PROJECTS[@]}"; do
    rm -rf "$project"
    echo "删除: $project"
  done
else
  echo "跳过安装"
fi

echo ""
echo "=========================================="
echo "  提示"
echo "=========================================="
echo ""
echo "1. 批量安装前建议先备份重要项目"
echo "2. 可以在脚本中添加错误处理逻辑"
echo "3. 使用dry-run模式先测试脚本"
echo "4. 考虑使用并行处理加速批量安装"
echo ""
