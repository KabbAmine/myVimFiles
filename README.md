# MyVimFiles

My vim configuration that I've done and still doing with :heart: for more than 2 years now.

It works on both GNU/Linux and Windows (But may be better on GNU/Linux).

I'm not a vim master, but my configuration works great for me so feel free to use it, improve it, love it or hate it... The choice is yours :sunglasses:.

*This configuration works also on neovim.*

<div style="text-align:center"><img src=".img/myVim.jpg"></img></div>

## Requirements & external programs

1. For the plugins:
	
	- *Vullscreen*: [Wmctrl<sup>B</sup>](http://tomas.styblo.name/wmctrl/)

	- *vCoolor*: [Yad](http://sourceforge.net/projects/yad-dialog/) or [Zenity<sup>B</sup>](https://wiki.gnome.org/action/show/Projects/Zenity)

	- *Tagbar*: [Exuberant ctags](http://ctags.sourceforge.net/)

	- *Syntastic*:

		- `csslint`<sup>N</sup>
		- `gcc`<sup>B</sup>
		- `javac`<sup>B</sup>
		- `jslint`<sup>N</sup>
		- `jsonlint`<sup>N</sup>
		- `pep8`<sup>P</sup>
		- `php`<sup>B</sup>
		- `python`<sup>B</sup>
		- `sass`<sup>R</sup>
		- `scss_lint`<sup>R</sup>
		- `shellcheck` & `sh`<sup>B</sup>
		- [`tidy5`](https://github.com/htacg/tidy-html5)
		- `vim-vint`<sup>P</sup>

	- *Autoformat*:
		
		- For `html`, `css` & `javascript` -> `js-beautify`<sup>N</sup>.
		- `scss` uses `sass-convert` which is shipped with `sass`.
	
	- *vim-livedown*: `livedown`<sup>N</sup>

2. For `~/.vim/ftplugin/` files (optional):
	- `markdown`<sup>B</sup>
	- `g++`<sup>B</sup>
	- `Evince`<sup>B</sup> in GNU/Linux to open generated pdf from Tex file compilation.

3. Fonts:

	- ['DejaVu Sans Mono for Powerline'](https://github.com/powerline/fonts) in Windows.
	- [Ubuntu Mono derivative Powerline Plus Nerd File Types'](https://github.com/ryanoasis/nerd-filetype-glyphs-fonts-patcher) in GNU/Linux.

-----------------------------

*<a id="B"><sup>B</sup></a> Present by default or easily installable on your system.*<br />
*<a id="N"><sup>N</sup></a> A npm package: `sudo npm -g install npmPackage`*<br />
*<a id="P"><sup>P</sup></a> A pip package: `sudo pip install pipPackage`*<br />
*<a id="R"><sup>R</sup></a> A ruby gem: `gem install rubyGem`*<br />

-----------------------------

## Instructions

```
git clone https://github.com/KabbAmine/myVimFiles ~/.vim
mkdir -pv ~/.vim/various/view ~/.vim/various/swap_dir ~/.vim/various/undodir
ln -s ~/.vim/vimrc ~/.vimrc		# Not required
" For Neovim
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
```

Then in Vim:

```
:PU		# Upgrade vim-plug
:PI		# Install all the plugins
```
Have fun :smile:

## Notes

This configuration is a little personal (Commands & mappings) but well documented, so you can use most of it by changing a few things.
