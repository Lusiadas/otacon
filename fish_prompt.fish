function fish_prompt

  # Capture exit status
  test "$status" -eq 0
  and set -l color cyan
  or set -l color red

  # Configure __fish_git_prompt
  set -g __fish_git_prompt_char_stateseparator ' '
  set -g __fish_git_prompt_color white
  set -g __fish_git_prompt_color_flags red
  set -g __fish_git_prompt_showdirtystate true
  set -g __fish_git_prompt_showuntrackedfiles true
  set -g __fish_git_prompt_showstashstate true
  set -g __fish_git_prompt_show_informative_status true
  set -g __fish_git_prompt_color white
  set -g __fish_git_prompt_color_flags red
  set -g __fish_git_prompt_color_prefix $color
  set -g __fish_git_prompt_color_suffix $color

  # Setup colors
  set -l reg (set_color normal)
  set color $reg(set_color $color)

  # Declare variables
  set --query __fish_prompt_hostname
  or set __fish_prompt_hostname (command hostname \
  | string match -v localhost \
  | cut -d . -f 1)
  set -l cwd (realpath $PWD 2>/dev/null | string replace ~ '~')
  set -l length (string length "$USER$__fish_prompt_hostname$cwd")
  set -l max_length (math "$COLUMNS - 12")
  if test $length -ge $max_length
    set cwd (prompt_pwd)
    set length (string length "$USER$__fish_prompt_hostname$cwd")
  end
  if not set --query __fish_prompt_char
    test (id -u) -eq 0
    and set -g __fish_prompt_char '#'
    or set -g __fish_prompt_char '>'
  end

  # Line 1
  echo -n $color'┌['$reg"$USER"
  test -z "$__fish_prompt_hostname"
  or echo -n $color'@'$reg"$__fish_prompt_hostname"
  echo -n $color']-('$reg"$cwd"$color')'$reg
  __fish_git_prompt "-[%s]"

  # Line 2
  echo -ne \n$color'└'$__fish_prompt_char $reg
end
