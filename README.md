# MyVimFiles

My configuration for the best program of the world :heart:  
I'm not a vim master, but my configuration works great for me so feel free to
use it, improve it, love it or hate it... The choice is yours :sunglasses:

![My vim](.img/myVim.jpg)

*It works on both GNU/Linux and Windows (But may be better on GNU/Linux) and ~~should be compatible with neovim~~*

## Requirements

All the following requirements on GNU/Linux are managed and installed via scripts from my [dotfiles](https://github.com/kabbamine/mydotfiles) repository, they are here just for reference (And for windows obviously :smile:).

1. For the plugins:
  - *Autoformat*:
    * For `html`, `css`, `json` & `javascript` -> `js-beautify`<sup>N</sup>
    * `sass-convert` for `scss` (Shipped with `sass`<sup>R</sup>)
    * `autopep8`<sup>P</sup> for `python`
  - *Unite*: `Ag`<sup>B</sup>
  - Checkers/Linters for *Syntastic*:
    * `csslint`<sup>N</sup>
    * `gcc`<sup>B</sup>
    * `javac`<sup>B</sup>
    * `jslint`<sup>N</sup>
    * `jsonlint`<sup>N</sup>
    * `flake8`<sup>P</sup>
    * `php`<sup>B</sup>
    * `python`<sup>B</sup>
    * `sass`
    * `sass_lint`<sup>N</sup>
    * `shellcheck` & `sh`<sup>B</sup>
    * [`tidy5`](https://github.com/htacg/tidy-html5)
    * `vim-vint`<sup>P</sup>
  - *vCoolor*: `yad`<sup>B</sup> or `zenity`<sup>B</sup>
2. External applications (Not mandatory):
  - `shiba`<sup>N</sup> for live preview of html/markdown
  - [`wmctrl`<sup>B</sup>](http://tomas.styblo.name/wmctrl/) for a lot of things :beer:
  - `live-server`<sup>N</sup> & `browser-sync`<sup>N</sup> for live preview of web projects using jobs.
3. Fonts:
  - [InconsolataForPowerline NF Medium](https://github.com/ryanoasis/nerd-fonts) for both GNU/Linux & windows (Included in the repo).

-----------------------------

*<a id="B"><sup>B</sup></a> Present by default or easily installable on your system.*  
*<a id="N"><sup>N</sup></a> A npm package*  
*<a id="P"><sup>P</sup></a> A pip package*  
*<a id="R"><sup>R</sup></a> A ruby gem*  

-----------------------------

## Instructions

```sh
git clone https://github.com/KabbAmine/myVimFiles ~/.vim
mkdir -pv ~/.vim/misc/templates ~/.vim/misc/view ~/.vim/misc/swap_dir ~/.vim/misc/undodir

# Link the font if you don't have it already
ln -s $HOME/.vim/misc/fonts/Inconsolata\ for\ Powerline\ Nerd\ Font\ Complete\ Windows\ Compatible.otf ~/.fonts/

# Not mandatory
ln -s ~/.vim/vimrc ~/.vimrc
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

This config is not a ready-to-use vim distribution, it contains a lot of settings that may no suit everyone, so take a look, test and take what you want :beer:.
