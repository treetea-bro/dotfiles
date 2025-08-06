# Mac
## keyboard
### open terminal and paste below
- defaults write NSGlobalDomain KeyRepeat -int 1
- defaults write NSGlobalDomain InitialKeyRepeat -int 12
- defaults write -g ApplePressAndHoldEnabled -bool false

## install
- [Karabiner](https://karabiner-elements.pqrs.org/)
### Karabiner setting
1. open karabiner
2. click Complex Modifications
3. click Add your own rule
4. copy and paste below
```json
{
    "description": "R_ALT to switch input languages",
    "manipulators": [
        {
            "from": { "key_code": "right_alt" },
            "to": [
                {
                    "key_code": "spacebar",
                    "lazy": true,
                    "modifiers": ["left_control", "left_alt"],
                    "repeat": false
                }
            ],
            "type": "basic"
        }
    ]
}
```
5. click save
- [Wezterm](https://wezfurlong.org/)
- [Nerd fonts](https://github.com/ryanoasis/nerd-fonts) : brew install --cask font-fira-code-nerd-font
- [Homebrew](https://brew.sh/ko/) : /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
- [Neovim](https://neovim.io/) : brew install neovim
- [Ripgrep](https://github.com/BurntSushi/ripgrep) : brew install ripgrep

## Clone
1. cd ~
2. git clone https://github.com/treetea-bro/dotfiles.git
3. rsync -avh --ignore-existing dotfiles/ .

## Setup
### Common
- [Rustup](https://www.rust-lang.org/tools/install) - Rustup installs The Rust Programming Language from the official release channels

### Shell
- [Nix](https://nixos.org/) - Declarative builds and deployments. (sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon)
- [Fish shell](https://fishshell.com/) - Fish prioritizes simplicity and ease of use (`chsh -s $(which fish)`)
- [Fisher](https://github.com/jorgebucaran/fisher) - Plugin manager
- [Tide](https://github.com/IlanCosman/tide) - Shell theme. Use version 5: `fisher install ilancosman/tide@v5`
- [Z for fish](https://github.com/jethrokuan/z) - Directory jumping (fisher install jethrokuan/z)
- [Eza](https://github.com/eza-community/eza) - `ls` replacement (cargo install eza)
- [Fzf](https://github.com/PatrickF1/fzf.fish) - Interactive filtering

### Tool
- [Mise](https://github.com/jdx/mise) - language manage tool (curl https://mise.run | sh)
- [Direnv](https://direnv.net/) - can load and unload environment variables depending on the current directory. (mise install direnv)
  
### Git
- [Ghq](https://github.com/x-motemen/ghq) - Local Git repository organizer (mise install ghq)
- [Lazygit](https://github.com/jesseduffield/lazygit) - A simple terminal UI for git commands (mise install lazygit) 
- [Git commitizen](https://commitizen-tools.github.io/commitizen/) - Commitizen is release management tool designed for teams. (first. mise install pipx && second. check link inside)

# Linux
## install neovim
sudo apt update  
sudo apt install -y software-properties-common  
sudo add-apt-repository --yes ppa:neovim-ppa/unstable  
sudo apt update  
sudo apt install -y neovim  

## install ripgrep
sudo apt install ripgrep  

## cloning settings
1. cd ~
2. git clone https://github.com/treetea-bro/dotfiles.git
3. rsync -avh --ignore-existing dotfiles/ .

## Setup
### Terminal
- [Nerd fonts](https://github.com/ryanoasis/nerd-fonts) - Powerline-patched fonts. I use Fira code.
- [Wezterm](https://wezfurlong.org/wezterm/) - WezTerm is a powerful cross-platform terminal emulator and multiplexer written by @wez and implemented in Rust

### Common
- [Rustup](https://www.rust-lang.org/tools/install) - Rustup installs The Rust Programming Language from the official release channels

### Shell
- [Nix](https://nixos.org/) - Declarative builds and deployments. (sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon)
- [Fish shell](https://fishshell.com/) - Fish prioritizes simplicity and ease of use (`chsh -s $(which fish)`)
- [Fisher](https://github.com/jorgebucaran/fisher) - Plugin manager
- [Tide](https://github.com/IlanCosman/tide) - Shell theme. Use version 5: `fisher install ilancosman/tide@v5`
- [Z for fish](https://github.com/jethrokuan/z) - Directory jumping (fisher install jethrokuan/z)
- [Eza](https://github.com/eza-community/eza) - `ls` replacement (cargo install eza)
- [Fzf](https://github.com/PatrickF1/fzf.fish) - Interactive filtering

### Tool
- [Mise](https://github.com/jdx/mise) - language manage tool (curl https://mise.run | sh)
- [Direnv](https://direnv.net/) - can load and unload environment variables depending on the current directory. (mise install direnv)
  
### Git
- [Ghq](https://github.com/x-motemen/ghq) - Local Git repository organizer (mise install ghq)
- [Lazygit](https://github.com/jesseduffield/lazygit) - A simple terminal UI for git commands (mise install lazygit) 
- [Git commitizen](https://commitizen-tools.github.io/commitizen/) - Commitizen is release management tool designed for teams. (first. mise install pipx && second. check link inside)

# windows
## keyboard
### open regedit
1. in address bar paste : HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response
2. change registries value
- AutoRepeatDelay : 180
- AutoRepeatRate : 6
- Flags : 59
- others (I mean, everything!) : 0
