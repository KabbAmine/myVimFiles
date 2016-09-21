# MyVimFiles

My configuration for the best program of the world :heart:  
I'm not a vim master, but my configuration works great for me so feel free to
use it, improve it, love it or hate it... The choice is yours :sunglasses:

![My vim](.img/myVim.jpg)

*It works on both GNU/Linux and Windows (But **IS better** on GNU/Linux) ~~and should be compatible with neovim~~*

## Requirements

### :one: Vim

You should have a relatively new version of vim which supports such features: `+job`, `+timers` and `+lambda` and compiled with `+python(3)`, `+ruby` and `+lua`.

### :two: Font(s)
  - [InconsolataForPowerline NF Medium](https://github.com/ryanoasis/nerd-fonts) for both GNU/Linux & windows (Included in the repo).

### :three: For the plugins:

The requirements listed below (GNU/Linux) are managed and installed via scripts from my [dotfiles](https://github.com/kabbamine/mydotfiles) repository, they are here just for reference (And for windows obviously :smile:).

#### Autoformat

| Filetype(s)                         | formatter
| :-------------------------          | :-------------------------
| `html`, `css`, `json`, `javascript` | `js-beautify`<sup>N</sup>
| `python`                            | `autopep8`<sup>P</sup>
| `sass/scss`                         | `sass-convert` (Shipped with `sass`<sup>R</sup>)

#### Syntastic & Validator

| filetype                   | checker/linter
| :------------------------- | :-------------------------
| `c`                        | `gcc`<sup>B</sup>
| `css`                      | `csslint`<sup>N</sup>
| `html`                     | [`tidy5`](https://github.com/htacg/tidy-html5)
| `java`                     | `javac`<sup>B</sup>
| `javascript`               | `eslint_d`<sup>N</sup>
| `json`                     | `jsonlint`<sup>N</sup>
| `lua`                      | `luac`<sup>B</sup>
| `php`                      | `php`<sup>B</sup>
| `python`                   | `flake8`<sup>P</sup>, `python`<sup>B</sup>
| `sass/scss`                | `sass_lint`<sup>N</sup>, `sass`
| `sh/bash`                  | `shellcheck`, `sh`<sup>B</sup>
| `viml`                     | `vim-vint`<sup>P</sup>
| `yaml`                     | `yamllint`<sup>P</sup>

#### Misc

- **gutentags**: `ctags-exuberant`<sup>B</sup>
- **Unite** (And not only): `Ag`<sup>B</sup>
- **vCoolor**: `yad`<sup>B</sup> or `zenity`<sup>B</sup>

### :four: External applications (Not mandatory):

  - `live-server`<sup>N</sup> & `browser-sync`<sup>N</sup> for live preview of web projects using jobs.
  - `shiba`<sup>N</sup> for live preview of html/markdown
  - [`wmctrl`<sup>B</sup>](http://tomas.styblo.name/wmctrl/) for a lot of things :beer:

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
