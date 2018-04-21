ln -s -f $script_dir/config/fish/config ~/.config/fish/config

echo "set CMD_CUSTOM_DIR $HOME/.cmd-custom"             >> $script_dir/cmd-custom/defvar.fish
echo "set CMD_CUSTOM_DIR_LOCAL $HOME/.cmd-custom/local" >> $script_dir/cmd-custom/defvar.fish
echo "set DOTFILES_SOURCE_DIR $script_dir"              >> $script_dir/cmd-custom/defvar.fish
echo "set DOTFILES_DIR $HOME/dotfiles"                  >> $script_dir/cmd-custom/defvar.fish
echo "set DOTFILES_PKGS_DIR $script_dir/config/pkgs"    >> $script_dir/cmd-custom/defvar.fish
echo "set DROPBOX_DIR $dropbox_dir"                     >> $script_dir/cmd-custom/defvar.fish

fisher install hasanozgan/theme-lambda
fisher install gitignore
fisher install autojump
fisher install joseluisq/gitnow
