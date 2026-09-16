# My current nvim-config

My current NeoVim configuration: a dark, keyboard-first setup for Python, C/C++, Rust, Go, shell scripts, Lua, and Batch/CMD files.

<p>
  <img alt="Neovim v0.11+" src="assets/badges/neovim.svg">
  <img alt="Plugin Manager lazy.nvim" src="assets/badges/plugin-manager.svg">
  <img alt="Lua LuaJIT" src="assets/badges/lua.svg">
  <img alt="License MIT" src="assets/badges/license.svg">
<p>

![Windows](https://img.shields.io/badge/Windows-Compatible-0078D6?logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA0ODc1IDQ4NzUiPjxwYXRoIGZpbGw9IiMwMDc4RDYiIGQ9Ik0wIDBoMjMxMXYyMzEwSDB6bTI1NjQgMGgyMzExdjIzMTBIMjU2NHpNMCAyNTY0aDIzMTF2MjMxMUgwem0yNTY0IDBoMjMxMXYyMzExSDI1NjQiLz48L3N2Zz4=)
![macOS](https://img.shields.io/badge/macOS-Compatible-000000?logo=apple&logoColor=white)
<img alt="Linux" src="assets/badges/linux.svg">

---

## This nvim-config has these features:

* **Plugin management:** [lazy.nvim](https://github.com/folke/lazy.nvim) bootstraps itself on first launch and loads every plugin from `nvim/lua/plugins/`;

* **Custom theme and editor defaults:** `mytheme` provides a high-contrast dark colour scheme, styled completion and floating windows, plus styled diagnostics. True colour, line numbers, cursor line and four-space indentation are enabled; `<leader>r` reloads the theme;

* **LSP:** Language-server support and completion capabilities for Python (Pyright with basic type checking), C/C++ (clangd), Rust (rust-analyzer), Go (gopls), Bash/Shell (bashls) and Lua (lua-language-server);

* **Smart autocompletion:** [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) integrates LSP suggestions and [LuaSnip](https://github.com/L3MON4D3/LuaSnip). Use `Tab` to accept the selected completion and `Ctrl-Space` to open it manually;

* **Formatting:** [conform.nvim](https://github.com/stevearc/conform.nvim) formats on save, with LSP fallback. It uses Ruff (Python), clang-format (C/C++), rustfmt (Rust), gofumpt (Go), shfmt (Shell/Bash) and stylua (Lua). `<leader>f` formats the current file on demand;

* **Asynchronous linting:** [nvim-lint](https://github.com/mfussenegger/nvim-lint) runs on opening, writing and leaving insert mode when the relevant executable is available: Ruff + MyPy, clang-tidy, Clippy, golangci-lint and ShellCheck;

* **Advanced syntax support:** [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) provides highlighting, indentation and expression-based folds for Python, C, C++, Rust, Go, Bash, Lua and Batch/CMD. Batch/CMD uses the external `tree-sitter-batch` grammar and the repository includes custom queries;

* **Tool installation:** [Mason](https://github.com/mason-org/mason.nvim), Mason LSP Config and Mason DAP manage language servers and debug adapters. The configured servers are Pyright, clangd, rust-analyzer, gopls, bashls and lua-language-server;

* **Debugging:** [nvim-dap](https://github.com/mfussenegger/nvim-dap) and its UI support Python, C/C++, Go, Bash and Lua debugging. Mason installs debugpy, codelldb, Delve and the Bash debug adapter; the DAP UI opens with a session and closes when it ends;

* **Testing:** [neotest](https://github.com/nvim-neotest/neotest) with the Python adapter runs the nearest test (`<leader>tr`) or the current file (`<leader>tf`), and provides a summary (`<leader>ts`) and output window (`<leader>to`);

* **Search and navigation:** [Telescope](https://github.com/nvim-telescope/telescope.nvim) with native FZF finds files (`Ctrl-P`), buffers (`Ctrl-B`), project text (`<leader>sg`), document symbols (`<leader>sd`), workspace symbols (`<leader>sw`) and LSP references (`<leader>sr`);

* **Git workflow:** [Gitsigns](https://github.com/lewis6991/gitsigns.nvim) shows, navigates (`]c` / `[c`), previews (`<leader>hp`) and stages hunks (`<leader>hs`), shows blame (`<leader>hb`) and opens a diff (`<leader>hd`). [LazyGit](https://github.com/kdheepak/lazygit.nvim) opens with `<leader>git` or for the current file with `<leader>fgit`;

* **File picker:** [Superfile](https://github.com/anaypurohit0907/superfile.nvim) opens its terminal picker with `<leader>spf` and returns the selected file to NeoVim;

* **Terminal and key discovery:** [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) opens a rounded floating Zsh terminal with `<leader>k`; [which-key.nvim](https://github.com/folke/which-key.nvim) shows mappings with `<leader>?`;

* **UI helpers:** indent guides from [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim), a diagnostics panel from [trouble.nvim](https://github.com/folke/trouble.nvim), and browser preview for Markdown through [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) (`:MarkdownPreview` / `:MarkdownPreviewToggle`);

* **Built-in help:** `K` opens LSP documentation for the symbol under the cursor; diagnostics use rounded floating windows and inline indicators.

<br>

---

## Plugin inventory:

### Main plugins

* lazy.nvim; mytheme; nvim-cmp; LuaSnip; nvim-lspconfig; Mason; mason-lspconfig; nvim-lint; conform.nvim;

* nvim-treesitter; Telescope; telescope-fzf-native; Gitsigns; LazyGit; Superfile; toggleterm; which-key; indent-blankline; trouble.nvim; markdown-preview.nvim;

* nvim-dap; nvim-dap-ui; mason-nvim-dap; nvim-dap-python; nvim-dap-go; neotest; neotest-python.

### Supporting dependencies

* cmp-nvim-lsp; plenary.nvim; nvim-nio; FixCursorHold.nvim; one-small-step-for-vimkind.

<br>

---

## Requirements:

* NeoVim >= 0.11.0;

* Git >= 2.19.0: required by lazy.nvim to download and manage plugins;

* A C compiler with C99/C11 support and `make`: required to compile Tree-sitter parsers and Telescope's native FZF extension;

* Node.js and npm >= 18: required by bashls, markdown-preview.nvim and some Mason-managed tools;

* Python >= 3.8 with pip and venv: required by Mason and Python tooling;

* A [Nerd Font](https://www.nerdfonts.com/): recommended for icons in completion menus and plugin UI;

* Optional external programs for their matching features: `lazygit`, `spf` (Superfile), `ruff`, `mypy`, `clang-format`, `clang-tidy`, `rustfmt`, `cargo`, `gofumpt`, `golangci-lint`, `shfmt`, `shellcheck` and `stylua`. Linters only run when their executable is available.

<br>

---

### If you don't have the base requirements installed, open the terminal and run:

#### Windows via Winget:

```powershell
winget install Neovim.Neovim Git.Git OpenJS.NodeJS MSYS2.MSYS2 Python.Python.3
```

#### Windows via Scoop:

```powershell
scoop install neovim git gcc make nodejs python
```

#### Windows via Chocolatey:

```powershell
choco install neovim git mingw make nodejs python
```

---

#### macOS via Homebrew:

```bash
brew install neovim git node gcc make python
```

---

#### Linux via pacman (Arch Linux-based):

```bash
sudo pacman -S neovim git base-devel nodejs npm python python-pip
```

#### Linux via apt (Debian-based):

```bash
sudo apt update && sudo apt install neovim git build-essential nodejs npm python3 python3-pip python3-venv
```

#### Linux via dnf (Fedora-based):

```bash
sudo dnf install neovim git gcc-c++ make nodejs npm python3 python3-pip
```

#### Linux via zypper (openSUSE-based):

```bash
sudo zypper install neovim git gcc-c++ make nodejs npm python3 python3-pip
```

<br>

---

## Installation:

The repository keeps the NeoVim configuration inside the `nvim/` directory. The commands below back up an existing configuration and copy that directory to the standard NeoVim location.

### macOS and Linux:

#### Via HTTPS:

```bash
git clone https://github.com/JohnnyRochaSoares/nvim-config.git
cd nvim-config
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null || true
mkdir -p ~/.config
cp -R nvim ~/.config/nvim
```

#### Via SSH:

```bash
git clone git@github.com:JohnnyRochaSoares/nvim-config.git
cd nvim-config
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null || true
mkdir -p ~/.config
cp -R nvim ~/.config/nvim
```

#### Via GitHub CLI:

```bash
gh repo clone JohnnyRochaSoares/nvim-config
cd nvim-config
mv ~/.config/nvim ~/.config/nvim.backup 2>/dev/null || true
mkdir -p ~/.config
cp -R nvim ~/.config/nvim
```

<br>

### Windows (PowerShell):

#### Via HTTPS:

```powershell
git clone https://github.com/JohnnyRochaSoares/nvim-config.git
cd nvim-config
if (Test-Path $env:LOCALAPPDATA\nvim) { Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.backup -Force }
Copy-Item -Recurse nvim $env:LOCALAPPDATA\nvim
```

#### Via SSH:

```powershell
git clone git@github.com:JohnnyRochaSoares/nvim-config.git
cd nvim-config
if (Test-Path $env:LOCALAPPDATA\nvim) { Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.backup -Force }
Copy-Item -Recurse nvim $env:LOCALAPPDATA\nvim
```

#### Via GitHub CLI:

```powershell
gh repo clone JohnnyRochaSoares/nvim-config
cd nvim-config
if (Test-Path $env:LOCALAPPDATA\nvim) { Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.backup -Force }
Copy-Item -Recurse nvim $env:LOCALAPPDATA\nvim
```

<br>

---

## First launch:

Open NeoVim with `nvim`. lazy.nvim installs the plugins automatically. Use `:Lazy` to inspect or update plugins, `:Mason` to manage language servers and debug adapters, and `:checkhealth` if a feature is not working.

<br>

---

## If you want to go back:

The previous configuration is saved as `nvim.backup` by the installation commands. Remove the installed configuration and restore it.

### macOS/Linux:

```bash
rm -rf ~/.config/nvim
mv ~/.config/nvim.backup ~/.config/nvim
```

### Windows (PowerShell):

```powershell
Remove-Item -Recurse -Force $env:LOCALAPPDATA\nvim
Move-Item $env:LOCALAPPDATA\nvim.backup $env:LOCALAPPDATA\nvim
```

<br>

---

## Contributing:

If you wish to contribute, feel free to do so!

<br>

---

## License:

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
