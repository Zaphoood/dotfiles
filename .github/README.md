# Dotfiles
I got the idea for managing my dotfiles this way from [this blogpost](https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/).

## Installing
Clone the repository
```
echo ".cfg" >> .gitignore
git clone https://github.com/Zaphoood/new-dotfiles $HOME/.cfg
```

Create an alias for managing the repository
```
alias dot-cfg='/usr/bin/git --git-dir=$HOME/.cfg/.git --work-tree=$HOME'
dot-cfg config --local status.showUntrackedFiles no
```

Useful tip: If you have want to commit all tracked files with changes to them, use `dot-cfg add -u` (instead of the usual `dot-cfg add -A`).

## Stuff
 * Window manager: [i3](https://i3wm.org/)
 * Compositor: [picom](https://github.com/yshui/picom)
 * Application launcher: [rofi](https://github.com/davatorium/rofi)
 * Lock screen: [i3lock-color](https://github.com/Raymo111/i3lock-color)
 * Markdown viewer: [glow](https://github.com/charmbracelet/glow)
 * Media control: [dbus-send](https://linux.die.net/man/1/dbus-send)
 * Font: [Caskaydia Cove NF](https://eng.m.fontke.com/font/64992431/download/)

## Thanks
My rofi theme was inspired by [Eric Murphy's](https://github.com/ericmurphyxyz/archrice) dotfiles.
