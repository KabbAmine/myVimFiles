" ========== Global vimrc (Unix & Windows) =======================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2014-11-20
" ================================================================


" Useful variables.
" {
	let g:hasUnix = has('unix')
	let g:hasWin = has('win32') || has('win64')
	" Stock the Location of vim's folder in a global variable.
	" {
		if g:hasWin
			let g:vimDir = "$HOME/vimfiles"
		else
			let g:vimDir = "$HOME/.vim"
		endif
	" }
" }

" Open personal config files for editing *******
" {
	" *** :Ev		=> ~/.vimrc
	" *** :Em		=> ~/.config/minimal-vimrc.vim
	" *** :Ep		=> ~/.config/plugins.vim
	" *** :Eb		=> ~/.dotfiles/bash/bashrc
	" *** :Ea		=> ~/.dotfiles/bash/bash_aliases
	" *** :Ef		=> ~/.dotfiles/bash/bash_functions
	" *** :Et		=> ~/.dotfiles/tmux/.tmux.conf
	command! Ev :e! $MYVIMRC
	execute "command! Em :e! ".g:vimDir."/config/minimal-vimrc.vim"
	execute "command! Ep :e! ".g:vimDir."/config/plugins.vim"
	command! Eb :e! $HOME/.dotfiles/bash/bashrc
	command! Ea :e! $HOME/.dotfiles/bash/bash_aliases
	command! Ef :e! $HOME/.dotfiles/bash/bash_functions
	command! Et :e! $HOME/.dotfiles/tmux/tmux.conf
" }

" Source external files.
" {
	" Plugins files.
	execute "source ".g:vimDir."/config/plugins.vim"

	" Minimal vimrc.
	execute "source ".g:vimDir."/config/minimal-vimrc.vim"
" }

