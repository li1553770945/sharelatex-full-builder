# Overleaf Full Version Autobuilder 🚀

**Automate the creation of a full TeX Live environment for Overleaf (ShareLaTeX) Community Edition.**

## 📖 Why this exists?
The official Overleaf Docker image (`sharelatex/sharelatex`) is lightweight and only includes `scheme-basic`. For advanced users or those writing academic theses (especially with CJK requirements), many packages like `ctex` are missing.

This project provides an automated workflow to:
1. **Auto-align with Official Tags**: The script detects the actual semantic version (e.g., `6.1.2`) behind the `latest` tag.
2. **Full Installation**: Installs `scheme-full` which includes all available packages.
3. **Custom Mirrors**: Support for local CTAN mirrors to speed up the build process.

## 🛠️ Getting Started

### 1. Prerequisites
Ensure you have `Docker` and `jq` installed:
```bash
sudo apt install jq

```

### 2. Configuration

Edit the `.env` file:

```bash
# Your Docker Hub repository
MY_REPO=yourname/overleaf-full

# The base official tag (e.g., latest, 5, 6.1.2)
OFFICIAL_TAG=latest

# CTAN mirror for tlmgr
TL_MIRROR=https://mirror.ctan.org/systems/texlive/tlnet

```

### 3. Build & Publish

Simply run the script:

```bash
chmod +x publish.sh
./publish.sh

```

## 📦 Outputs

Two tags will be pushed to your repository:

* `${MY_REPO}:latest`
* `${MY_REPO}:[Specific_Version]` (e.g., `6.1.2`)

## 📄 License

This project is licensed under the MIT License.

