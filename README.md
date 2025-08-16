# Keyboard
## Mac
### Open terminal then paste below then restart computer to apply
- defaults write NSGlobalDomain KeyRepeat -int 1
- defaults write NSGlobalDomain InitialKeyRepeat -int 12
- defaults write -g ApplePressAndHoldEnabled -bool false  

## Windows
### Open regedit
1. In address bar paste : HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response
2. Change registries value
- AutoRepeatDelay : 180
- AutoRepeatRate : 6
- Flags : 59
- Others (I mean, every other!) : 0  

# Nix
1. Install [Nix](https://nixos.org/)
2. Install [Home-manager](https://nix-community.github.io/home-manager/)

# Clone
1. cd ~
2. git clone git@github.com:treetea-bro/dotfiles.git
3. rsync -avh --ignore-existing dotfiles/ .
4. home-manager switch  

# Mac
1. System Settings > Privacy & Security > Full Disk Access > Enable WezTerm
