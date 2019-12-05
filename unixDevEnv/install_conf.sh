#!/bin/bash
conf_dir='./user_root'
ect_dir='./user_etc'
if [[ -d "$conf_dir" && -d "$ect_dir" ]]; then
	cp user_root/bashrc ~/.bashrc
	if (( $? == 0 )); then echo "Copied: .bashrc"; fi
	cp user_root/gitconfig ~/.gitconfig
	if (( $? == 0 )); then echo "Copied: .gitconfig"; fi
	cp user_root/tmux.conf ~/.tmux.conf
	if (( $? == 0 )); then echo "Copied: .tmux.conf"; fi

	mkdir -p ~/.config/nvim/
	mkdir -p ~/.config/gtags/
	mkdir -p ~/.local/share/nvim/site/autoload/
	cp user_root/init.vim ~/.config/nvim/
	if (( $? == 0 )); then echo "Copied: init.vim"; fi
	cp user_root/plug.vim ~/.local/share/nvim/site/autoload/
	if (( $? == 0 )); then echo "Copied: plug.vim"; fi
	cp user_etc/gtags.conf ~/.config/gtags/
	if (( $? == 0 )); then echo "Copied: gtags.conf"; fi
fi
echo "Done"
