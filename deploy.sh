#!/usr/bin/env bash
set -euo pipefail
# lemo-opuscar 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/lemomo-ai/lemo-opuscar#how-to-use
# 更新日期：2026-11-03
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v node >/dev/null 2>&1 || { echo "需要先安装 Node.js"; exit 1; }
command -v python3 >/dev/null 2>&1 || command -v python >/dev/null 2>&1 || { echo "需要先安装 Python 3"; exit 1; }

mkdir -p .download
cd .download

claude plugin marketplace add lemomo-ai/lemo-opuscar
claude plugin install lemo-opuscar@lemolab
echo "装好后在 Claude Code 里输入 /lemo-opuscar:lemo-opuscar"

echo ""

echo "部署完成"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/lemomo-ai/lemo-opuscar#how-to-use"
