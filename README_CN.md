# Overleaf Full Version Autobuilder 🚀

**解决官方 Overleaf 社区版镜像宏包缺失（如 `ctex`）的痛点，一键构建全量 TeX Live 镜像。**

## 📖 背景
官方的 Overleaf (ShareLaTeX) Docker 镜像为了控制体积，仅包含了基础版的 TeX Live (`scheme-basic`)。这导致在撰写毕业论文或使用中文排版时，经常报错 `LaTeX Error: File ctexrep.cls not found`。

本项目提供了一套自动化方案：
1. **自动对齐官方版本**：脚本会自动检测官方 `latest` 标签背后的真实版本号。
2. **全量安装**：自动安装 `scheme-full`，包含所有官方宏包。
3. **国内加速**：支持通过清华 TUNA 镜像源加速下载。

## 🛠️ 快速开始

### 1. 准备环境
确保你的服务器已安装 `Docker` 和 `jq` (用于解析版本号)：
```bash
sudo apt install jq  # Ubuntu/Debian

```

### 2. 配置环境变量

修改或创建 `.env` 文件：

```bash
# 你要推送到 Docker Hub 的仓库名
MY_REPO=yourname/sharelatex-full

# 想要基于的官方版本 (如 latest, 5, 6.1.2)
OFFICIAL_TAG=latest

# TeX Live 镜像源 (国内推荐 TUNA)
TL_MIRROR=[https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet](https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet)

```

### 3. 构建并推送

运行自动化脚本：

```bash
bash build-and-push.sh
```

## 📦 产出镜像

构建成功后，你将获得两个标签的镜像：

* `${MY_REPO}:latest`
* `${MY_REPO}:[具体版本号]` (例如 `6.1.2`)

## 🤝 贡献

欢迎提交 Pull Request 或 Issue。如果你也是正在熬夜写论文的博士生，加油！
