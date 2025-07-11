# (macOS & Linux)
## sequence
1. install neovim
2. install ripgrep
3. git clone
4. move the folder and files to home directory (rsync -avh --ignore-existing dotfiles/ .)
5. install setups

## install neovim (Linux version)
sudo apt update  
sudo apt install -y software-properties-common  
sudo add-apt-repository --yes ppa:neovim-ppa/unstable  
sudo apt update  
sudo apt install -y neovim  

## install ripgrep (Linux version)
sudo apt install ripgrep  

## keyboard (mac only)
### open terminal and paste below
- defaults write NSGlobalDomain KeyRepeat -int 1
- defaults write NSGlobalDomain InitialKeyRepeat -int 12

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
- others : 0
## Setup
- [Windows Terminal](https://apps.microsoft.com/detail/9n0dx20hk701) - Terminal application for users of command-line tools and shells like Command Prompt, PowerShell, and WSL.
- [Nerd fonts](https://github.com/ryanoasis/nerd-fonts) - Powerline-patched fonts. I use Hack.
- [Powershell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows) - Cross-platform command-line interface and scripting language for system and network administration
- [Oh My Posh](https://ohmyposh.dev/) - A prompt theme engine for any shell.
- [Lazyvim](https://www.lazyvim.org/) - LazyVim is a Neovim setup powered by 💤 lazy.nvim to make it easy to customize and extend your config.
- [Z](https://www.powershellgallery.com/packages/z/) - Directory jumping
- [Git commitizen](https://commitizen-tools.github.io/commitizen/) - Commitizen is release management tool designed for teams.
- [Lazygit](https://github.com/jesseduffield/lazygit) - A simple terminal UI for git commands

### Powershell Setup
[System.Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", "C:\Users\<YourUsername>\.config", [System.EnvironmentVariableTarget]::User)
