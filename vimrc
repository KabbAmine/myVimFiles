" ========== Global vimrc (Unix & Windows) =======================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2015-01-03
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
		execute "command! Evm :e! ".g:vimDir."/config/minimal-vimrc.vim"
		execute "command! Evp :e! ".g:vimDir."/config/plugins.vim"
		command! Eb :e! $HOME/.dotfiles/bash/bashrc
		command! Eba :e! $HOME/.dotfiles/bash/bash_aliases
		command! Ebf :e! $HOME/.dotfiles/bash/bash_functions
		command! Et :e! $HOME/.dotfiles/tmux/tmux.conf
" }

" Automatically source vimrc & config files on save.
" {
	augroup resource
		autocmd!
		autocmd bufwritepost $MYVIMRC source $MYVIMRC
		execute "autocmd bufwritepost ".expand(g:vimDir)."/config/* source $MYVIMRC"
	augroup END
" }

" Source external files.
" {
	" Minimal vimrc.
	execute "source ".g:vimDir."/config/minimal-vimrc.vim"

	" Plugins files.
	execute "source ".g:vimDir."/config/plugins.vim"
" }

