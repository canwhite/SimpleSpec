#!/bin/bash

#############################################
# 快速开始示例 - 在新项目中安装配置
#############################################

set -e

echo "=========================================="
echo "  Claude Code 配置快速安装示例"
echo "=========================================="
echo ""

# 示例1: 在单个项目中安装
echo "示例1: 在当前项目中安装"
echo "-----------------------------------"
echo "命令: curl -fsSL https://raw.githubusercontent.com/yourusername/claude-code-config/main/install.sh | bash"
echo ""

# 示例2: 指定版本安装
echo "示例2: 安装特定版本"
echo "-----------------------------------"
echo "命令: curl -fsSL https://raw.githubusercontent.com/yourusername/claude-code-config/v1.0.0/install.sh | bash"
echo ""

# 示例3: 使用wget安装
echo "示例3: 使用wget安装"
echo "-----------------------------------"
echo "命令: wget -qO- https://raw.githubusercontent.com/yourusername/claude-code-config/main/install.sh | bash"
echo ""

# 示例4: 本地文件安装
echo "示例4: 从本地文件安装"
echo "-----------------------------------"
echo "命令: bash /path/to/install.sh install"
echo ""

# 实际演示
echo "=========================================="
echo "  实际演示"
echo "=========================================="
echo ""

# 检查是否在项目目录中
if [ -f ".git" ] || [ -d ".git" ] || [ -f "package.json" ] || [ -f "composer.json" ]; then
    echo "✅ 检测到项目目录"

    # 询问是否安装
    read -p "是否要在当前项目中安装 Claude Code 配置? (y/n) " -n 1 -r
    echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "开始安装..."
        curl -fsSL https://raw.githubusercontent.com/yourusername/claude-code-config/main/install.sh | bash
        echo "✅ 安装完成！"
    else
        echo "❌ 取消安装"
    fi
else
    echo "⚠️  当前目录似乎不是一个项目目录"
    echo "建议在项目根目录中运行此脚本"

    # 创建示例项目
    read -p "是否要创建示例项目并演示安装? (y/n) " -n 1 -r
    echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "创建示例项目..."
        mkdir -p example-project
        cd example-project
        git init
        echo "# Example Project" > README.md

        echo "安装配置..."
        curl -fsSL https://raw.githubusercontent.com/yourusername/claude-code-config/main/install.sh | bash

        echo "✅ 示例项目创建完成！"
        echo "项目位置: $(pwd)"
    fi
fi

echo ""
echo "=========================================="
echo "  更多示例"
echo "=========================================="
echo ""
echo "查看批量安装示例:"
echo "  cat examples/batch-install.sh"
echo ""
echo "查看文档:"
echo "  cat README.md"
echo ""
