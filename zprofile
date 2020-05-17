if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
elif command -v firefox &> /dev/null; then
    export BROWSER=firefox
elif command -v chromium &> /dev/null; then
    export BROWSER=chromium
fi

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

typeset -gU cdpath fpath mailpath path

if [[ ! $PATH =~ "/usr/local/bin" && -d /usr/local/bin ]]; then
    export PATH=/usr/local/bin:$PATH
fi

export LESS='-F -g -i -M -R -S -w -X -z-4'

if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

source $HOME/.config/shell/defvar.sh

for f in $HOME/.config/shell/env/*.sh; do
    if [ -f $file ]; then
        source $f
    fi
done

for f in $HOME/.config/shell/env/*.zsh; do
    if [ -f $file ]; then
        source $f
    fi
done

for file in $SHELL_CUSTOM_DIR/env.local/*.sh; do
    if [ -f $file ]; then
        source $file
    fi
done
for file in $SHELL_CUSTOM_DIR/env.local/*.zsh; do
    if [ -f $file ]; then
        source $file
    fi
done
