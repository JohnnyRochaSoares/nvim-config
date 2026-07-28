# My current init.lua
My current init.lua configuration for NeoVim on macOS.

[![macOS](https://img.shields.io/badge/macOS-Supported-000000?logo=apple&logoColor=white)](...)

<br>

## This .zshrc configuration has 6 features:

* Initialize Starship;

* Initialize direnv;

* Set Git output in english;

* Bind "⌥ + backspace" to delete word-by-word;

* "mkcd" ("mkdir" + "cd") command to create and change to that directory;

* "cdrm" ("cd .." + "rm -r") command to go up on one directory and remove the directory you've just left.

<br>

---

## Requirements:

* Starship;

* Direnv.

<br>

---

#### If you don't have it installed, open the terminal and run:

```bash
brew install starship direnv    # Install starship and direnv via brew
```

<br>

---

## Installation:

##### **Via Https:**

1. Open your terminal;
2. Type the following commands:

```bash
git clone https://github.com/JohnnyRochaSoares/My-.zshrc-configuration.git  # Clone the GitHub repository
cd My-.zshrc-configuration                                                  # Go to the project directory
cp ~/.zshrc ~/.zshrc.backup 2>/dev/null                                     # Backup existing configuration (if it exists)
cp .zshrc ~/.zshrc                                                          # Install the new configuration
source ~/.zshrc                                                             # Reload the configuration
```
<br>

---

 ##### **Via SSH:**

1. Open your terminal;
2. Type the following commands:

```bash
git clone git@github.com:JohnnyRochaSoares/My-.zshrc-configuration.git      # Clone the GitHub repository
cd My-.zshrc-configuration                                                  # Go to the project directory
cp ~/.zshrc ~/.zshrc.backup 2>/dev/null                                     # Backup existing configuration (if it exists)
cp .zshrc ~/.zshrc                                                          # Install the new configuration
source ~/.zshrc                                                             # Reload the configuration
```

<br>

---

##### **Via GitHub CLI:**

1. Open your terminal;
2. Type the following commands:

```bash
gh repo clone JohnnyRochaSoares/My-.zshrc-configuration     # Clone the GitHub repository
cd My-.zshrc-configuration                                  # Go to the project directory
cp ~/.zshrc ~/.zshrc.backup 2>/dev/null                     # Backup existing configuration (if it exists)
cp .zshrc ~/.zshrc                                          # Install the new configuration
source ~/.zshrc                                             # Reload the configuration
```

<br>

---

## If you want to go back:

If you want to go back to your previous configuration, open your terminal and run:

```bash
cp ~/.zshrc.backup ~/.zshrc
source ~/.zshrc
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
