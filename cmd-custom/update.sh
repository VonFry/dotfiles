function vonfry-update()
{
    ECHO_SYM="\033[0;31m"
    ECHO_MSG="\033[0;36m"
    ECHO_RST="\033[0m"
    current_dir=$(pwd)

    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}update start${ECHO_RST}"

    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}dotfiles${ECHO_RST}\n"
    cd $DOTFILES_DIR
    git pull

    case "$(uname)" in
        "Darwin")
            echo -e "\n${ECHO_SYM}* ${ECHO_MSG}system: $(uname)${ECHO_RST}"
            echo -e "\n${ECHO_SYM}** ${ECHO_MSG}homebrew${ECHO_RST}\n"
            brew update
            brew upgrade
            brew cask upgrade
            brew cleanup
            echo -e "\n${ECHO_SYM}** ${ECHO_MSG}app store${ECHO_RST}\n"
            sudo softwareupdate --install --all
            echo -e "\n${ECHO_SYM}--- ${ECHO_MSG}You may run /usr/local/opt/fzf/install to install fzf${ECHO_RST}"
            ;;
        # if ctags is updated, emacs needs being recompiled.
        "Linux")
            source /etc/os-release
            echo -e "\n${ECHO_SYM}* ${ECHO_MSG}system: ${ID}${ECHO_RST}"
            case "$ID" in
                "fedora")
                    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}dnf${ECHO_RST}\n"
                    sudo dnf clean all
                    sudo dnf update -y
                    sudo dnf clean all
                    ;;
                "gentoo")
                    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}portage${ECHO_RST}"
                    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}sync portage and custom repos${ECHO_RST}\n"
                    sudo eix-sync -q # This action contains portage/layman sync.
                    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}portage self${ECHO_RST}\n"
                    sudo emerge --oneshot --quiet portage
                    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}layman${ECHO_RST}\n"
                    sudo haskell-updater --quiet
                    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}portage worlds${ECHO_RST}"
                    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}If use flag has been changed, run emerge with --newuse or --changed-use. This updating dosen't contain them.${ECHO_RST}\n"
                    sudo emerge --quiet --update --deep --with-bdeps=y @world
                    sudo emerge --depclean --quiet
                    ;;
            esac
            ;;
    esac

    if command -v antigen >/dev/null 2>&1; then
        echo -e "\n${ECHO_SYM}* ${ECHO_MSG}antigen${ECHO_RST}\n"
        antigen update
        antigen selfupdate
    fi

    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}sources${ECHO_RST}"
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}lsp${ECHO_RST}\n"
    echo -e "\n${ECHO_SYM}*** ${ECHO_MSG}cquery${ECHO_RST}\n"
    cd ~/.local/src/cquery
    git remote update
    if [ $(git rev-parse @) = $(git rev-parse '@{u}') ]; then
        git checkout -- .
        git clean -fd
        rm -r ./build
        rm .*waf*
        git pull --depth 1
        git submodule update --depth 1
        ./waf configure --llvm-config=llvm-config
        ./waf build
    fi
    echo -e "\n${ECHO_SYM}*** ${ECHO_MSG}haskell-ide-engine${ECHO_RST}\n"
    cd ~/.local/src/haskell-ide-engine
    git remote update
    if [ $(git rev-parse @) = $(git rev-parse '@{u}') ]; then
        git checkout -- .
        git clean -fd
        git pull --depth 1
        git submodule update --depth 1
        stack install
    fi

    cd $current_dir

    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}haskell${ECHO_RST}"
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}cabal${ECHO_RST}\n"
    cabal update --verbose=0
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}stack${ECHO_RST}\n"
    stack update --silent
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}hoogle${ECHO_RST}\n"
    hoogle generate --quiet
    echo -e "\n${ECHO_MSG}All things with haskell are only updated with indexed file, please update each package by yourself."
    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}python${ECHO_RST}"
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}pip3${ECHO_RST}\n"
    if [ $(uname) = Darwin ]; then
        pip3 install --quiet --upgrade -r $DOTFILES_DIR/config/pkgs/pip3.txt
    else
        pip3 install --quiet --user --upgrade -r $DOTFILES_DIR/config/pkgs/pip3.txt
    fi
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}pip2${ECHO_RST}\n"
    if [ $(uname) = Darwin ]; then
        pip2 install --quiet --upgrade -r $DOTFILES_DIR/config/pkgs/pip2.txt
    else
        pip2 install --quiet --user --upgrade -r $DOTFILES_DIR/config/pkgs/pip2.txt
    fi
    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}ruby${ECHO_RST}"
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}gem${ECHO_RST}\n"
    gem update --silent && gem update --system --silent
    gem cleanup
    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}npm${ECHO_RST}\n"
    if [ $(uname) = Linux ]; then
        sudo npm update -g --silent
    else
        npm update -g --silent
    fi

    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}R${ECHO_RST}"
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}packages${ECHO_RST}\n"
    R --slave --quiet -e "update.packages(ask = FALSE, quiet = TRUE)"

    if [ -f ~/.vimrc ]; then
        echo -e "\n${ECHO_SYM}* ${ECHO_MSG}vim${ECHO_RST}"
        echo -e "\n${ECHO_SYM}** ${ECHO_MSG}vundle${ECHO_RST}\n"
        vim -c "execute \"PluginUpdate\" | qa"
        echo -e "\n${ECHO_SYM}** ${ECHO_MSG}ycm${ECHO_RST}\n"
        python3 ~/.vim/bundle/YouCompleteMe/install.py --tern-completer --clang-completer --system-boost --system-libclang --quiet
        cd ~/.vim/bundle/vimproc.vim/ && make
    fi

    if [ -f ~/.emacs.d/init.el ]; then
        echo -e "\n${ECHO_SYM}* ${ECHO_MSG}Emacs${ECHO_RST}"
        echo -e "\n${ECHO_SYM}-- ${ECHO_MSG}Emacs will be killed.${ECHO_RST}"
        killall emacs
        emacs --batch --load $DOTFILES_DIR/emacs.d/init.el --eval "(package-refresh-contents)" --eval "(vonfry/update-all-packages)"
        unset whether_do_kill
    fi

    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}update end ${ECHO_RST}\n"

    cd $current_dir

    unset ECHO_SYM
    unset ECHO_MSG
    unset ECHO_RST
    unset current_dir
    echo $(_current_epoch) >! $CMD_CUSTOM_DIR/local/.update_epoch
}

update_epoch_file=$CMD_CUSTOM_DIR/local/.update_epoch
need_update=1
if [ -f $update_epoch_file ]; then
    read last_update < $update_epoch_file
    during_last_update=$(($(_current_epoch) - $last_update))
    if [ $during_last_update -ge 7 ]; then
       need_update=0
    fi
    unset during_last_update
    unset last_update
else
    need_update=0
fi
if [ $need_update = 0 ] ; then
    echo -e "\n${ECHO_SYM}[vonfry]${ECHO_MSG} Would you like to check for updates? [Y/n]:${ECHO_RST}\c"
    read whether_do_update
    if [[ $whether_do_update = y* ]] || [[ $whether_do_update == Y* ]] || [ -z $whether_do_update ]; then
        vonfry-update
    fi
    unset whether_do_update
fi
unset update_epoch_file
unset need_update
