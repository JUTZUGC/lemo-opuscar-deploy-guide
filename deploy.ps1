# lemo-opuscar 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/lemomo-ai/lemo-opuscar#how-to-use
# 更新日期：2026-11-03
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw '需要先安装 Node.js' }
if (-not (Get-Command python -ErrorAction SilentlyContinue)) { throw '需要先安装 Python 3' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

claude plugin marketplace add lemomo-ai/lemo-opuscar
claude plugin install lemo-opuscar@lemolab
Write-Host "装好后在 Claude Code 里输入 /lemo-opuscar:lemo-opuscar"

Write-Host ''

Write-Host '部署完成'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/lemomo-ai/lemo-opuscar#how-to-use'
