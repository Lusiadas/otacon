function fish_greeting
  test "$TMUX"
  or return 0
  command grep -P '^source-file.*tmuxtheme$' $HOME/.tmux.conf | read theme
  string match -qr 'otacon\.tmuxtheme' $theme
  and return 0
  omf cd otacon
  command realpath otacon.tmuxtheme | read otacon_theme
  test "$theme"
  and sed -i "s/$theme/otacon_theme/g" $HOME/.tmux.conf
  or echo "source-file $otacon_theme" >> $HOME/.tmux.conf
  tmux source-file $HOME/.tmux.conf
  prevd
end