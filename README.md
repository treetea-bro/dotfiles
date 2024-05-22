## keyboard
### mac
#### open terminal and paste below
- defaults write NSGlobalDomain KeyRepeat -int 1
- defaults write NSGlobalDomain InitialKeyRepeat -int 12
### windows
#### open regedit
1. in address bar paste : HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response
2. change registries value
- AutoRepeatDelay : 180
- AutoRepeatRate : 6
- Flags : 59
- others : 0

## Shell setup (macOS & Linux)
- [Kitty](https://sw.kovidgoyal.net/kitty/) - Offloads rendering to the GPU for lower system load
- [Fish shell](https://fishshell.com/) - Fish prioritizes simplicity and ease of use
- [Fisher](https://github.com/jorgebucaran/fisher) - Plugin manager
- [Tide](https://github.com/IlanCosman/tide) - Shell theme. Use version 5: `fisher install ilancosman/tide@v5`
- [Nerd fonts](https://github.com/ryanoasis/nerd-fonts) - Powerline-patched fonts. I use Hack.
- [z for fish](https://github.com/jethrokuan/z) - Directory jumping
- [Eza](https://github.com/eza-community/eza) - `ls` replacement
- [ghq](https://github.com/x-motemen/ghq) - Local Git repository organizer
- [fzf](https://github.com/PatrickF1/fzf.fish) - Interactive filtering
- [mise](https://github.com/jdx/mise) - language manage tool
