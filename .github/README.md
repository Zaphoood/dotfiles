# Dotfiles
The idea for my current method of managing my dotfiles came from [this blogpost](https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/), which in turn refers to [this article](https://www.atlassian.com/git/tutorials/dotfiles).

## Installing
Clone the repository
```
echo ".dotfiles" >> .gitignore
git clone https://github.com/Zaphoood/dotfiles $HOME/.dotfiles
```

Create an alias for managing the repository
```
alias dot-cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME'
dot-cfg config --local status.showUntrackedFiles no
```

## Programs I use

 * Editor: [neovim](https://neovim.io/) with [vim-plug](https://github.com/junegunn/vim-plug) as a plugin manager
 * File exlporer: [ranger](https://github.com/ranger/ranger) with [Überzug](https://github.com/seebye/ueberzug)
 * Markdown viewer: [glow](https://github.com/charmbracelet/glow)

## Thanks

Thanks go out to [Eric Murphy's](https://github.com/ericmurphyxyz/archrice), whose rofi theme I used for inspiration.
