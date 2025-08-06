# Mac
## Keyboard
### Open terminal then paste below then restart computer to apply
- defaults write NSGlobalDomain KeyRepeat -int 1
- defaults write NSGlobalDomain InitialKeyRepeat -int 12
- defaults write -g ApplePressAndHoldEnabled -bool false  
### Karabiner
1. Install [Karabiner](https://karabiner-elements.pqrs.org/)
2. Open Karabiner app
3. Click Complex Modifications
4. Click Add your own rule
5. Copy and paste below
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
6. Click save

## Pre install
- [Homebrew](https://brew.sh/ko/) : /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
- [Wezterm](https://wezfurlong.org/)
- [Nerd fonts](https://github.com/ryanoasis/nerd-fonts) : brew install --cask font-fira-code-nerd-font

## Clone
1. cd ~
2. git clone git@github.com:treetea-bro/dotfiles.git
3. rsync -avh --ignore-existing dotfiles/ .

## Post install
- [Fish shell](https://fishshell.com/) : brew install fish
- [Fisher](https://github.com/jorgebucaran/fisher) : curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
- Fisher-homebrew : fisher install oh-my-fish/plugin-brew
- [Starship](https://starship.rs/guide/) : brew install starship
- [Nix](https://nixos.org/) : curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh
- [Eza](https://github.com/eza-community/eza) : nix profile add nixpkgs#eza --extra-experimental-features nix-command --extra-experimental-features flakes
- [Z for fish](https://github.com/jethrokuan/z) : fisher install jethrokuan/z
- [Fzf](https://github.com/PatrickF1/fzf.fish) - brew install fzf && brew install fd && brew install bat && fisher install PatrickF1/fzf.fish
- [Neovim](https://neovim.io/) : brew install neovim
- [Ripgrep](https://github.com/BurntSushi/ripgrep) : brew install ripgrep
- [Mise](https://github.com/jdx/mise) : brew install mise
- [Direnv](https://direnv.net/) : mise install direnv && mise use -g direnv

### Git
- [Ghq](https://github.com/x-motemen/ghq) : mise install ghq && mise use -g ghq
- [Lazygit](https://github.com/jesseduffield/lazygit) : mise install lazygit && mise use -g lazygit
- [Git commitizen](https://commitizen-tools.github.io/commitizen/) : mise install pipx && mise use -g pipx
- [Git commitizen](https://commitizen-tools.github.io/commitizen/) : pipx install commitizen

# Windows
## Keyboard
### Open regedit
1. In address bar paste : HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response
2. Change registries value
- AutoRepeatDelay : 180
- AutoRepeatRate : 6
- Flags : 59
- Others (I mean, every other!) : 0  

# Linux (Ubuntu)
## Pre install
- [Wezterm](https://wezfurlong.org/)
- [Nerd fonts](https://github.com/ryanoasis/nerd-fonts)

## Clone
1. cd ~
2. git clone git@github.com:treetea-bro/dotfiles.git
3. rsync -avh --ignore-existing dotfiles/ .

## Post install
- [Fish shell](https://fishshell.com/) - Fish prioritizes simplicity and ease of use (`chsh -s $(which fish)`)
- [Fisher](https://github.com/jorgebucaran/fisher)
- [Starship](https://starship.rs/guide/)
- [Nix](https://nixos.org/) : sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
- [Eza](https://github.com/eza-community/eza)
- [Z for fish](https://github.com/jethrokuan/z) : fisher install jethrokuan/z
- [Fzf](https://github.com/PatrickF1/fzf.fish)
- [Mise](https://github.com/jdx/mise) : curl https://mise.run | sh
- [Direnv](https://direnv.net/) : mise install direnv && mise use -g direnv
  
### Git
- [Ghq](https://github.com/x-motemen/ghq) : mise install ghq && mise use -g ghq
- [Lazygit](https://github.com/jesseduffield/lazygit) : mise install lazygit && mise use -g lazygit
- [Git commitizen](https://commitizen-tools.github.io/commitizen/) : mise install pipx && mise use -g pipx
- [Git commitizen](https://commitizen-tools.github.io/commitizen/) : pipx install commitizen

### Install neovim
sudo apt update  
sudo apt install -y software-properties-common  
sudo add-apt-repository --yes ppa:neovim-ppa/unstable  
sudo apt update  
sudo apt install -y neovim  

### Install ripgrep
sudo apt install ripgrep 
