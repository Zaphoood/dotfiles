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

## Stuff
 * Window manager: [i3](https://i3wm.org/)
 * Application launcher: [rofi](https://github.com/davatorium/rofi)
 * Lock screen: [i3lock-color](https://github.com/Raymo111/i3lock-color)
 * Font: [Caskaydia Cove NF](https://eng.m.fontke.com/font/64992431/download/)
 * Media control: [dbus-send](https://linux.die.net/man/1/dbus-send)

## Thanks
My rofi theme was inspired by [Eric Murphy's](https://github.com/ericmurphyxyz/archrice) dotfiles.
