# My current nvim-config
My current NeoVim configuration.

[![Neovim](https://img.shields.io/badge/Neovim-57A143?logo=neovim&logoColor=fff)](#)
[![Lua](https://img.shields.io/badge/Lua-%232C2D72.svg?logo=lua&logoColor=white)](#)

[![Windows](https://custom-icon-badges.demolab.com/badge/Windows-0078D6?logo=windows11&logoColor=white)](#)
[![macOS](https://img.shields.io/badge/macOS-Supported-000000?logo=apple&logoColor=white)](#)
[![Linux](https://img.shields.io/badge/-Linux-grey?logo=linux)](#)

## This nvim-config has 10 features:

* Uses lazy.nvim for plugin manager;

* Custom Theme (mytheme.lua);

* LSP:

    * Python: PyRight with basic type checking;

    * C/C++: Clangd;

* Smart Autocompletion: nvim-cmp setup integrated with LSP and snippet expansion via LuaSnip;

* Format on save: Integration with conform.nvim for automatic formatting when saving files (ruff);

* Asynchronous Linting: Uses Ruff and MyPy;

* Advanced Syntax Highlighting: nvim-treesitter configured for syntax coloring;

* Dependency management: Easy Installation of third-party formatters and linters using mason.nvim;

* Diagnostics Panel: trouble-nvim integration to list all project errors, warnings and issues in a single workspace view;

* Markdown support: Live in browser preview for Markdown files using markdown-preview.nvim.

<br>

---

## Requirements:

* NeoVim;

* Git: Required by lazy.nvim to download and manage plugins;

* C Compiler (gcc or clang): Required by nvim-treesitter to compile language parsers;

* Node.js & npm: Required by markdown-preview.nvim to build the preview application;

* Python 3 (with pip & venv): Required by mason.nvim to install and isolate Python tools (Ruff, MyPy); 

<br>

---

### If you don't have it installed, open the terminal and run:

#### Windows via Winget:

```bash
winget install Neovim.Neovim Git.Git OpenJS.NodeJS MSYS2.MSYS2 Python.Python.3
```

#### Windows via Scoop:

```bash
scoop install neovim git gcc nodejs python
```

#### Windows via Chocolatey:

```bash
choco install neovim git mingw nodejs python
```

---

#### macOS via HomeBrew:

```bash
brew install neovim git node gcc python
```

#### macOS via Port:

```bash
sudo port install neovim git gcc13 nodejs20 npm10 python314
```

---

#### Linux via pacman (Arch Linux-based):

```bash
sudo pacman -S neovim git gcc nodejs npm python python-pip
```

#### Linux via apt (Debian-based):

```bash
sudo apt update && sudo apt install neovim git build-essential nodejs npm python3 python3-pip python3-venv
```

#### Linux via dnf (Fedora-based):

```bash
sudo dnf install neovim git gcc-c++ nodejs npm python3 python3-pip
```

#### Linux via zypper (openSUSE-based):

```bash
sudo zypper install neovim git gcc-c++ nodejs npm python3 python3-pip
```

<br>

---

## Installation:

### Linux and macOS:

#### Via HTTPS:

```bash
git clone https://github.com/JohnnyRochaSoares/nvim-config.git                      # Clone the GitHub repository
cd nvim-config                                                                      # Go to the project directory
cp -r ~/.config/nvim && cp -r . ~/.config/nvim                                      # Backup the existing configuration (if it exists)
mkdir -p ~/.config/nvim && cp -r . ~7.config/nvim                                   # Install the new configuration
```

#### Via SSH:

```
git clone git@github.com:JohnnyRochaSoares/nvim-config.git                          # Clone the GitHub repository
cd nvim-config                                                                      # Go to the project directory
cp -r ~/.config/nvim ~/.config/nvim.backup 2>/dev/null                              # Backup existing configuration (if it exists)
mkdir -p ~/.config/nvim && cp -r . ~/.config/nvim                                   # Install the new configuration
```

#### Via GitHub CLI:

```
gh repo clone JohnnyRochaSoares/nvim-config                                         # Clone the GitHub repository
cd nvim-config                                                                      # Go to the project directory
cp -r ~/.config/nvim ~/.config/nvim.backup 2>/dev/null                              # Backup existing configuration (if it exists)
mkdir -p ~/.config/nvim && cp -r . ~/.config/nvim                                   # Install the new configuration
```

<br>

### Windows (PowerShell):

#### Via HTTPS:

```powershell
git clone https://github.com/JohnnyRochaSoares/nvim-config.git                      # Clone the GitHub repository
cd nvim-config                                                                      # Go to the project directory
cp -Recurse $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.backup 2>$null            # Backup existing configuration (if it exists)
mkdir -Force $env:LOCALAPPDATA\nvim; cp -Recurse * $env:LOCALAPPDATA\nvim           # Install the new configuration
```

#### Via SSH:

```powershell
git clone git@github.com:JohnnyRochaSoares/nvim-config.git                          # Clone the GitHub repository
cd nvim-config                                                                      # Go to the project directory
cp -Recurse $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.backup 2>$null            # Backup existing configuration (if it exists)
mkdir -Force $env:LOCALAPPDATA\nvim; cp -Recurse * $env:LOCALAPPDATA\nvim           # Install the new configuration
```

#### Via GitHub CLI:

```powershell
gh repo clone JohnnyRochaSoares/nvim-config                                         # Clone the GitHub repository
cd nvim-config                                                                      # Go to the project directory
cp -Recurse $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.backup 2>$null            # Backup existing configuration (if it exists)
mkdir -Force $env:LOCALAPPDATA\nvim; cp -Recurse * $env:LOCALAPPDATA\nvim           # Install the new configuration
```

<br>

### Windows (CMD)

#### Via HTTPS:

```bash
git clone https://github.com/JohnnyRochaSoares/nvim-config.git                      & :: Clone the GitHub repository
cd nvim-config                                                                      $ :: Go to the project directory
xcopy "%LOCALAPPDATA%\nvim" "%LOCALAPPDATA%\nvim.backup" /E /I /H /Y >nul 2>&1      & :: Backup existing configuration (if it exists)
xcopy . "%LOCALAPPDATA%\nvim\" /E /I /H /Y                                          & :: Install the new configuration
```

#### Via SSH:

```bash
git clone git@github.com:JohnnyRochaSoares/nvim-config.git                          & :: Clone the GitHub repository
cd nvim-config                                                                      & :: Go to the project directory
xcopy "%LOCALAPPDATA%\nvim" "%LOCALAPPDATA%\nvim.backup" /E /I /H /Y >nul 2>&1      & :: Backup existing configuration (if it exists)
xcopy . "%LOCALAPPDATA%\nvim\" /E /I /H /Y                                          & :: Install the new configuration
```

#### Via GitHub CLI:

```bash
gh repo clone JohnnyRochaSoares/nvim-config                                         & :: Clone the GitHub repository
cd nvim-config                                                                      & :: Go to the project directory
xcopy "%LOCALAPPDATA%\nvim" "%LOCALAPPDATA%\nvim.backup" /E /I /H /Y >nul 2>&1      & :: Backup existing configuration (if it exists)
xcopy . "%LOCALAPPDATA%\nvim\" /E /I /H /Y                                          & :: Install the new configuration
```

<br>

---

## If you want to go back:

If you want to go back to your previous configuration, open your terminal and run:

### macOS/Linux:

```bash
rm -rf ~/.config/nvim                                                               # Remove current configuration
cp -r ~/.config/nvim.backup ~/.config/nvim                                          # Restore backup configuration
```

### Windows (PowerShell):

```powershell
Remove-Item -Recurse -Force $env:LOCALAPPDATA\nvim 2>$null                          # Remove current configuration
cp -Recurse $env:LOCALAPPDATA\nvim.backup$env:LOCALAPPDATA\nvim                     # Restore backup configuration
```

### Windows (CMD):

```bash
rmdir /s /q "%LOCALAPPDATA%\nvim" 2>nul                                             & :: Remove current configuration
xcopy "%LOCALAPPDATA%\nvim.backup" "%LOCALAPPDATA%\nvim\" /E /I /H /Y               & :: Restore backup configuration
```

<br>

---

## Contributing:

If you wish to contribute, feel free to do so!

<br>

---
## License:
This project is licensed under the MIT License.
See the [LICENSE](LICENSE) file for more information.
