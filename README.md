# MyVimFiles

My configuration for the best program of the world :heart:  
I'm not a vim master, but my configuration works great for me so feel free to use it, improve it, love it or hate it... The choice is yours :sunglasses:

![My vim](.img/myVim.png)

*It works on both GNU/Linux and Windows (But may be better on GNU/Linux) and is compatible with neovim*

## Requirements

1. For the plugins:
	- *Autoformat*:
		- For `html`, `css`, `json` & `javascript` -> `js-beautify`<sup>N</sup>
		- `scss` uses `sass-convert` which is shipped with `sass`<sup>R</sup>
	- *CtrlP* & *vim-grepper*: `Ag`<sup>B</sup>
	- *Syntastic*:
		- `csslint`<sup>N</sup>
		- `gcc`<sup>B</sup>
		- `javac`<sup>B</sup>
		- `jslint`<sup>N</sup>
		- `jsonlint`<sup>N</sup>
		- `pep8`<sup>P</sup>
		- `php`<sup>B</sup>
		- `python`<sup>B</sup>
		- `sass`
		- `scss_lint`<sup>R</sup>
		- `shellcheck` & `sh`<sup>B</sup>
		- [`tidy5`](https://github.com/htacg/tidy-html5)
		- `vim-vint`<sup>P</sup>
	- *Tagbar*: [Exuberant ctags](http://ctags.sourceforge.net/)
	- *vCoolor*: `yad`<sup>B</sup> or `zenity`<sup>B</sup>
	- *vim-livedown*: `livedown`<sup>N</sup>
	- *Vullscreen*: [`wmctrl`<sup>B</sup>](http://tomas.styblo.name/wmctrl/)
2. Fonts:
	- ['DejaVu Sans Mono for Powerline'](https://github.com/powerline/fonts) in Windows.
	- [Ubuntu Mono derivative Powerline Plus Nerd File Types'](https://github.com/ryanoasis/nerd-filetype-glyphs-fonts-patcher) in GNU/Linux.

-----------------------------

*<a id="B"><sup>B</sup></a> Present by default or easily installable on your system.*<br />
*<a id="N"><sup>N</sup></a> A npm package: `sudo npm -g install npmPackage`*<br />
*<a id="P"><sup>P</sup></a> A pip package: `sudo pip install pipPackage`*<br />
*<a id="R"><sup>R</sup></a> A ruby gem: `gem install rubyGem`*<br />

-----------------------------

## Instructions

```sh
git clone https://github.com/KabbAmine/myVimFiles ~/.vim
mkdir -pv ~/.vim/various/templates ~/.vim/various/view ~/.vim/various/swap_dir ~/.vim/various/undodir
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
