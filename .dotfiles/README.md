# Dotfiles
The idea for managing dotfiles this way was stolen from [this blogpost](https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/).

## Installing
Clone the repository
```
echo ".cfg" >> .gitignore
git clone https://github.com/Zaphoood/new-dotfiles $HOME/.cfg
alias dot-cfg='/usr/bin/git --git-dir=$HOME/.cfg/.git --work-tree=$HOME'
config dot-cfg --local status.showUntrackedFiles no
config checkout
```

## Programs used
 * Window manager: [i3](https://i3wm.org/)
 * Lock screen: [i3lock-color](https://github.com/Raymo111/i3lock-color)
