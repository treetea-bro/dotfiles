## Keyboard
### Open terminal then paste below then restart computer to apply
- defaults write NSGlobalDomain KeyRepeat -int 1
- defaults write NSGlobalDomain InitialKeyRepeat -int 12
- defaults write -g ApplePressAndHoldEnabled -bool false  

## Nix
1. Install [Nix](https://nixos.org/)
2. Copy and paste below
```code
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager  
nix-channel --update  
nix-shell '<home-manager>' -A install  
```

## Clone
1. cd ~
2. git clone git@github.com:treetea-bro/dotfiles.git
3. rsync -avh --ignore-existing dotfiles/ .

## Post install
- [Fish shell](https://fishshell.com/) : brew install fish
- [Fisher](https://github.com/jorgebucaran/fisher) : curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
- Fisher-homebrew : fisher install oh-my-fish/plugin-brew
- [Starship](https://starship.rs/guide/) : brew install starship

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
