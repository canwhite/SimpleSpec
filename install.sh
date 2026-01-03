#!/bin/bash

#############################################
# Claude Code 配置文件自动安装脚本
# 版本: 1.0.0
# 作者: Claude Code Assistant
# 说明: 一键安装.claudecode.json和CLAUDE.md配置
#############################################

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 配置
SCRIPT_VERSION="1.0.0"
REPO_URL="https://raw.githubusercontent.com/canwhite/SimpleSpec/main"
BACKUP_DIR=".claude-code-backup"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# 日志函数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 显示标题
show_banner() {
    echo -e "${BLUE}"
    echo "============================================"
    echo "  Claude Code 配置文件安装脚本 v${SCRIPT_VERSION}"
    echo "============================================"
    echo -e "${NC}"
}

# 检查依赖
check_dependencies() {
    log_info "检查依赖..."

    if ! command -v curl &> /dev/null && ! command -v wget &> /dev/null; then
        log_error "需要 curl 或 wget 来下载文件"
        exit 1
    fi

    log_success "依赖检查完成"
}

# 备份现有配置
backup_existing_config() {
    log_info "备份现有配置..."

    # 创建备份目录
    mkdir -p "${BACKUP_DIR}"

    # 备份.claudecode.json
    if [ -f ".claudecode.json" ]; then
        cp .claudecode.json "${BACKUP_DIR}/.claudecode.json.${TIMESTAMP}"
        log_success "已备份 .claudecode.json"
    fi

    # 备份CLAUDE.md
    if [ -f "CLAUDE.md" ]; then
        cp CLAUDE.md "${BACKUP_DIR}/CLAUDE.md.${TIMESTAMP}"
        log_success "已备份 CLAUDE.md"
    fi

    # 备份schema目录（如果存在）
    if [ -d "schema" ]; then
        cp -r schema "${BACKUP_DIR}/schema.${TIMESTAMP}"
        log_success "已备份 schema 目录"
    fi
}

# 下载文件
download_file() {
    local url=$1
    local dest=$2
    local description=$3

    log_info "下载 ${description}..."

    if command -v curl &> /dev/null; then
        if curl -fsSL "${url}" -o "${dest}"; then
            log_success "${description} 下载完成"
            return 0
        fi
    elif command -v wget &> /dev/null; then
        if wget -q "${url}" -O "${dest}"; then
            log_success "${description} 下载完成"
            return 0
        fi
    fi

    log_error "${description} 下载失败"
    return 1
}

# 安装配置文件
install_config() {
    log_info "开始安装配置文件..."

    # 下载.claudecode.json
    if ! download_file "${REPO_URL}/.claudecode.json" ".claudecode.json" ".claudecode.json"; then
        log_error "安装失败"
        rollback
        exit 1
    fi

    # 下载CLAUDE.md
    if ! download_file "${REPO_URL}/CLAUDE.md" "CLAUDE.md" "CLAUDE.md"; then
        log_error "安装失败"
        rollback
        exit 1
    fi

    # 创建schema目录
    mkdir -p schema/archive

    log_success "配置文件安装完成"
}

# 回滚功能
rollback() {
    log_warning "开始回滚..."

    if [ -f "${BACKUP_DIR}/.claudecode.json.${TIMESTAMP}" ]; then
        cp "${BACKUP_DIR}/.claudecode.json.${TIMESTAMP}" .claudecode.json
        log_info "已恢复 .claudecode.json"
    fi

    if [ -f "${BACKUP_DIR}/CLAUDE.md.${TIMESTAMP}" ]; then
        cp "${BACKUP_DIR}/CLAUDE.md.${TIMESTAMP}" CLAUDE.md
        log_info "已恢复 CLAUDE.md"
    fi

    log_warning "回滚完成"
}

# 列出备份
list_backups() {
    log_info "可用的备份："

    if [ ! -d "${BACKUP_DIR}" ]; then
        log_warning "没有找到备份目录"
        return
    fi

    ls -lh "${BACKUP_DIR}" | grep -v "^total" | awk '{print $9}' | while read -r backup; do
        if [ -n "$backup" ]; then
            echo "  - ${backup}"
        fi
    done
}

# 清理旧备份
clean_old_backups() {
    log_info "清理30天前的备份..."

    if [ -d "${BACKUP_DIR}" ]; then
        find "${BACKUP_DIR}" -type f -mtime +30 -delete 2>/dev/null || true
        log_success "旧备份清理完成"
    fi
}

# 显示帮助信息
show_help() {
    cat << EOF
用法: $0 [选项]

选项:
  install     安装配置文件（默认）
  rollback    回滚到最近的备份
  backups     列出所有备份
  clean       清理30天前的旧备份
  help        显示此帮助信息

示例:
  $0 install              # 安装配置
  $0 rollback             # 回滚配置
  $0 backups              # 查看备份列表
  $0 clean                # 清理旧备份

远程安装:
  curl -fsSL ${REPO_URL}/install.sh | bash
  wget -qO- ${REPO_URL}/install.sh | bash

EOF
}

# 主函数
main() {
    show_banner

    # 解析命令行参数
    local command=${1:-install}

    case "$command" in
        install)
            check_dependencies
            backup_existing_config
            install_config
            log_success "安装完成！"
            ;;
        rollback)
            rollback
            ;;
        backups)
            list_backups
            ;;
        clean)
            clean_old_backups
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            log_error "未知命令: $command"
            show_help
            exit 1
            ;;
    esac
}

# 执行主函数
main "$@"
