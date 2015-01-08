# MyVimFiles

This repo contains my vim configuration that I've done and still doing with :heart: for more than 2 years now, and some other vim folders.

It works on both GNU/Linux and Windows (But may be better in GNU/Linux).

I'm not a vim master, but my configuration works great for me so feel free to use it, improve it, love it or hate it... The choice is yours :sunglasses:.

![My vim](.img/myVim.png)

## Requirements & external programs

1. For the plugins:

	- [Exuberant ctags](http://ctags.sourceforge.net/) for *tagbar*.
		
	- *Syntastic*:

		- `gcc`^*^
		- `javac`^*^
		- `php`^*^
		- `python`^*^
		- `sh`^*^
		- `jslint`    ->  `npm install -g jslint`
		- `w3`* for html
		- `csslint`   ->  `npm install -g csslint`
		- `sass`      ->  `gem install sass`
		- `scss-lint` ->  `gem install scss-lint`

	- *Autoformat*:
		
		- For html, css & javascript -> `npm install -g js-beautify`.
		- For scss, `sass-convert` shipped with `sass`.

2. For `~/.vim/ftplugin/` files (optional):
	- `markdown`^*^
	- `g++`^*^
	- `Evince`^*^ in GNU/Linux to open generated pdf from Tex file compilation.

^*^ *Present by default, or easily installable in your distribution.*

## Instructions

```
git clone https://github.com/KabbAmine/myVimFiles ~/.vim
mkdir -pv ~/.vim/various/view ~/.vim/various/swap_dir ~/.vim/various/undodir
ln -s ~/.vim/vimrc ~/.vimrc		# Not required
```

Then in Vim:

```
:PU		# Upgrade vim-plug
:PI		# Install all the plugins
```
Have fun :smile:

## Notes

This configuration is a little personal (Commands & mappings) but well documented, so you can use most of it by changing a few things, just take a look on the files before using them.
