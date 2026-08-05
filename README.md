# My current nvim-config
My current NeoVim configuration.

<a href="#" style="text-decoration: none; display: inline-block; vertical-align: middle; position: relative; top: -7.5px;"><span style="display: inline-flex; align-items: center; height: 20px; font-family: Verdana, Geneva, sans-serif; font-size: 11px; line-height: 20px; border-radius: 3px; overflow: hidden; vertical-align: middle;"><span style="display: inline-flex; align-items: center; background-color: #555; color: #fff; padding: 0 7px; height: 100%;"><img src="https://upload.wikimedia.org/wikipedia/commons/3/3a/Neovim-mark.svg" height="13" style="width: auto; margin-right: 5px; vertical-align: middle;" alt="Neovim">Neovim</span><span style="background-color: #57A143; color: #fff; padding: 0 7px; height: 100%;">v0.10+</span></span></a>
<a href="https://github.com/folke/lazy.nvim" style="text-decoration: none; display: inline-block; vertical-align: middle; position: relative; top: -7.5px;"><span style="display: inline-flex; align-items: center; height: 20px; font-family: Verdana, Geneva, sans-serif; font-size: 11px; line-height: 20px; border-radius: 3px; overflow: hidden; vertical-align: middle;"><span style="display: inline-flex; align-items: center; background-color: #555; color: #fff; padding: 0 7px; height: 100%;"><img src="https://upload.wikimedia.org/wikipedia/commons/3/3a/Neovim-mark.svg" height="13" style="width: auto; margin-right: 5px; vertical-align: middle;" alt="lazy.nvim">Plugin Manager</span><span style="background-color: #000000; color: #fff; padding: 0 7px; height: 100%;">lazy.nvim</span></span></a>
<a href="#" style="text-decoration: none; display: inline-block; vertical-align: middle; position: relative; top: -7.5px;"><span style="display: inline-flex; align-items: center; height: 20px; font-family: Verdana, Geneva, sans-serif; font-size: 11px; line-height: 20px; border-radius: 3px; overflow: hidden; vertical-align: middle;"><span style="display: inline-flex; align-items: center; background-color: #555; color: #fff; padding: 0 7px; height: 100%;"><img src="https://upload.wikimedia.org/wikipedia/commons/c/cf/Lua-Logo.svg" height="13" style="width: auto; margin-right: 5px; vertical-align: middle;" alt="Lua">Lua</span><span style="background-color: #000080; color: #fff; padding: 0 7px; height: 100%;">5.1 (JIT 2.1)</span></span></a>
<a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT"></a>

<br>

<a href="#" style="text-decoration: none; display: inline-block; vertical-align: middle; position: relative; top: -7.5px;"><span style="display: inline-flex; align-items: center; height: 20px; font-family: Verdana, Geneva, sans-serif; font-size: 11px; line-height: 20px; border-radius: 3px; overflow: hidden; vertical-align: middle;"><span style="display: inline-flex; align-items: center; background-color: #555; color: #fff; padding: 0 7px; height: 100%;"><img src="https://upload.wikimedia.org/wikipedia/commons/8/87/Windows_logo_-_2021.svg" height="12" style="width: auto; margin-right: 5px; vertical-align: middle;" alt="Windows">Windows</span><span style="background-color: #0078D6; color: #fff; padding: 0 7px; height: 100%;">Supported</span></span></a>
<a href="#"><img src="https://img.shields.io/badge/macOS-Supported-000000?logo=apple&logoColor=white" alt="macOS"></a>
<a href="#" style="text-decoration: none; display: inline-block; vertical-align: middle; position: relative; top: -7.5px;"><span style="display: inline-flex; align-items: center; height: 20px; font-family: Verdana, Geneva, sans-serif; font-size: 11px; line-height: 20px; border-radius: 3px; overflow: hidden; vertical-align: middle;"><span style="display: inline-flex; align-items: center; background-color: #555; color: #fff; padding: 0 7px; height: 100%;"><img src="https://upload.wikimedia.org/wikipedia/commons/a/af/Tux.png" height="13" style="width: auto; margin-right: 4px; vertical-align: middle;" alt="Linux">Linux</span><span style="background-color: #E5A00D; color: #fff; padding: 0 7px; height: 100%;">Supported</span></span></a>

---


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

* NeoVim >= 0.10.0;

* Git >= 2.19.0: Required by lazy.nvim to download and manage plugins;

* C Compiler (gcc or clang) with support to C99/C11: Required by nvim-treesitter to compile language parsers;

* Node.js & npm >= 18.0.0: Required by markdown-preview.nvim to build the preview application;

* Python (with pip & venv) >= 3.8: Required by mason.nvim to install and isolate Python tools (Ruff, MyPy); 

* Nerd Font (e.g., Monaco Nerd Font, JetBrainsMono Nerd Font): Required by trouble.nvim, nvim-cmp and UI elements to render icons properly in your terminal.

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

### macOS and Linux:

#### Via HTTPS:

```bash
git clone https://github.com/JohnnyRochaSoares/nvim-config.git                      # Clone the GitHub repository
cd nvim-config                                                                      # Go to the project directory
cp -r ~/.config/nvim ~/.config/nvim.backup 2>/dev/null                              # Backup the existing configuration (if it exists)
mkdir -p ~/.config/nvim && cp -r . ~/.config/nvim                                   # Install the new configuration
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
cd nvim-config                                                                      & :: Go to the project directory
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
cp -Recurse $env:LOCALAPPDATA\nvim.backup $env:LOCALAPPDATA\nvim                    # Restore backup configuration
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
