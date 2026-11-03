# lemo-opuscar 一键安装指南

> 第三方部署指南 · 非 lemo-opuscar 官方仓库。官方项目：[lemomo-ai/lemo-opuscar](https://github.com/lemomo-ai/lemo-opuscar)
> 内容来自官方文档（2026-11-03）。项目迭代快，请以[官方文档](https://github.com/lemomo-ai/lemo-opuscar#how-to-use)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用自己敲命令，让百度搭子帮你把环境跑起来。

⚠️ 为 Claude 调优，推荐 Claude Opus 5.5。需要 Node 20+、ffmpeg 7+ 与 Python 3.11+（或 uv）；Ubuntu 24.04 自带的 ffmpeg 6.1 太旧，要换静态构建。风格库是提示词加代码示例，不是视频生成模型，成片质量取决于模型与你的选择。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/lemo-opuscar-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会用 Claude Code 插件市场添加并安装 lemo-opuscar 风格库，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## lemo-opuscar 是什么？

lemo-opuscar 是开源的不是视频模型，而是 66 套用代码复刻的电影风格，挑一套就能开拍（协议：MIT，<img src="https://img.shields.io/github/stars/lemomo-ai/lemo-opuscar?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

电影风格工具箱：66 种用代码实现的拍摄风格，每种包含风格提示与示例片，可让 Claude 按选定风格生成分镜、动画与配乐。

- 66 种现成电影风格
- 用代码做片，不依赖视频模型
- 支持自定义并保存风格
- Claude Code 插件安装
- 示例片可直接对照
- MIT，可改

（来源：[官方仓库](https://github.com/lemomo-ai/lemo-opuscar)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 11459 stars | 名称搜索 22 条（每页 20 条时两页） |
| 66 种风格可直接套用 | — |
| 不依赖视频生成服务 | — |
| 支持自定义风格 | — |
| Claude 插件安装简单 | — |
| MIT | 可改 |

| 需要注意 | 说明 |
|---|---|
| 为 Claude 调优 | 其他模型效果未知 |
| 不是开箱即用的视频模型 | — |
| ffmpeg 7+ 门槛较高 | — |
| 成片耗时 | — |
| 项目很新 | 风格格式可能变 |

> 以上基于官方文档与社区反馈整理（2026-11-03），以官方最新文档为准。

## 快速部署（官方方式）

```bash
claude plugin marketplace add lemomo-ai/lemo-opuscar
claude plugin install lemo-opuscar@lemolab
echo "装好后在 Claude Code 里输入 /lemo-opuscar:lemo-opuscar"
```

部署步骤来源：[https://github.com/lemomo-ai/lemo-opuscar#how-to-use](https://github.com/lemomo-ai/lemo-opuscar#how-to-use)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认 66 种风格、Claude 插件安装与依赖版本 | 已核对 2026-11-03 |
| 未实测安装与出片 | 说明 2026-11-03 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-11-03 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-11-03 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

以 Claude Code 插件形式安装，本身不含 MCP；本仓库的 MCP 只提供安装步骤与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-11-03）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\lemo-opuscar-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 依赖

| 项目 | 版本 |
|---|---|
| Node | 20+ |
| ffmpeg | 7+ |
| Python | 3.11+ 或 uv |

## 怎么用

1. 安装插件
2. 输入 `/lemo-opuscar:lemo-opuscar`
3. 选语言，再选用库里的风格或描述自己的
4. Claude 按风格出片

## 风格

- 66 种现成风格，每种带示例
- 也可以从一句话或参考图开始，让 Claude 找最接近的技术底子
- 自定义风格保存在本地，库更新不会覆盖

## 注意

- 不是视频生成模型，别期待一键出片
- 成片依赖 Claude 的代码与动画能力
- ffmpeg 版本过低会直接失败
- 示例片只作风格参考，素材版权需自行确认
- MIT，可自用可二开

## 常见坑

- 插件装不上：确认 Claude Code 已登录且支持 marketplace
- ffmpeg 版本低：换 7+ 静态构建
- 没有示例片：检查资源是否完整下载
- 风格不对：换一个更接近的库风格再微调
- 自定义被覆盖：确认保存在本地目录
- 渲染失败：检查 Node 与 Python 版本

## 免责声明

本仓库为第三方指南，与 lemo-opuscar 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-11-03），项目迭代快，请以[官方文档](https://github.com/lemomo-ai/lemo-opuscar#how-to-use)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
