# MyVimFiles

My configuration for the best program of the world :heart:  
I'm not a vim master, but my configuration works great for me so feel free to
use it, improve it, love it or hate it... The choice is yours :sunglasses:

![My vim](.img/myVim.jpg)

*It works on both GNU/Linux and Windows (But may be better on GNU/Linux) and is
compatible with neovim (Need more testing after the commits of 2016-02-07)*

## Requirements

1. For the plugins:
  - *Autoformat*:
    * For `html`, `css`, `json` & `javascript` -> `js-beautify`<sup>N</sup>
    * `scss` uses `sass-convert` which is shipped with `sass`<sup>R</sup>
  - *Unite*: `Ag`<sup>B</sup>
  - Checkers/Linters for *Syntastic*:
    * `csslint`<sup>N</sup>
    * `gcc`<sup>B</sup>
    * `javac`<sup>B</sup>
    * `jslint`<sup>N</sup>
    * `jsonlint`<sup>N</sup>
    * `pep8`<sup>P</sup>
    * `php`<sup>B</sup>
    * `python`<sup>B</sup>
    * `sass`
    * `sass_lint`<sup>N</sup>
    * `shellcheck` & `sh`<sup>B</sup>
    * [`tidy5`](https://github.com/htacg/tidy-html5)
    * `vim-vint`<sup>P</sup>
  - *vCoolor*: `yad`<sup>B</sup> or `zenity`<sup>B</sup>
  - *Vullscreen*: [`wmctrl`<sup>B</sup>](http://tomas.styblo.name/wmctrl/)
2. External applications:
  - For live preview of html/markdown: `shiba`<sup>N</sup>
3. Fonts:
  - [Inconsolata for Powerline Nerd Font Complete Windows Compatible.otf](https://github.com/ryanoasis/nerd-fonts) for both GNU/Linux & windows (Included in the repo).

-----------------------------

*<a id="B"><sup>B</sup></a> Present by default or easily installable on your system.*<br />
*<a id="N"><sup>N</sup></a> A npm package: `sudo npm -g install npmPackage`*<br />
*<a id="P"><sup>P</sup></a> A pip package: `sudo pip install pipPackage`*<br />
*<a id="R"><sup>R</sup></a> A ruby gem: `gem install rubyGem`*<br />

-----------------------------

## Instructions

```sh
git clone https://github.com/KabbAmine/myVimFiles ~/.vim
mkdir -pv ~/.vim/misc/templates ~/.vim/misc/view ~/.vim/misc/swap_dir ~/.vim/misc/undodir
# Link the font
ln -s $HOME/.vim/misc/fonts/Inconsolata\ for\ Powerline\ Nerd\ Font\ Complete\ Windows\ Compatible.otf ~/.fonts/
# Not mandatory
ln -s ~/.vim/vimrc ~/.vimrc
# For Neovim
ln -s ~/.vim "$XDG_CONFIG_HOME/nvim"
```

Then in Vim:

```vim
" Update vim-plug
PlugUpgrade
" Install all the plugins
PlugInstall
```
Have fun :smile:

## Notes

Note to myself, make a bootstrap-like script.
