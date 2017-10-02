function vonfry-update()
{
    ECHO_SYM="\033[0;31m"
    ECHO_MSG="\033[0;36m"
    ECHO_RST="\033[0m"

    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}update start${ECHO_RST}\n"

    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}oh my zsh${ECHO_RST}\n"
    upgrade_oh_my_zsh

    case "$(uname)" in
        "Darwin")
            echo -e "\n${ECHO_SYM}* ${ECHO_MSG}system: $(uname)${ECHO_RST}\n"
            echo -e "\n${ECHO_SYM}** ${ECHO_MSG}homebrew${ECHO_RST}\n"
            brew update
            brew upgrade
            brew cleanup
            echo -e "\n${ECHO_SYM}** ${ECHO_MSG}app store${ECHO_RST}\n"
            sudo softwareupdate --install --all
            ;;
        # if ctags is updated, emacs needs being recompiled.
        "Linux")
            source /etc/os-release
            echo -e "\n${ECHO_SYM}* ${ECHO_MSG}system: ${ID}${ECHO_RST}\n"
            case "$ID" in
                "fedora")
                    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}dnf${ECHO_RST}\n"
                    sudo dnf clean all
                    sudo dnf update -y
                    sudo dnf clean all
                    ;;
                "gentoo")
                    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}portage${ECHO_RST}\n"
                    emerge-webrsync
                    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}layman${ECHO_RST}\n"
                    layman-update -R
                    layman --sync-all
                    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}portage pkgs${ECHO_RST}\n"
                    emerge --sync
                    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}portage worlds${ECHO_RST}\n"
                    emerge --update --changed-use --deep --with-bdeps=y @world
                    revdep-rebuild
                    ;;
            esac
            ;;
    esac

    echo "You may run /usr/local/opt/fzf/install to install fzf"

    if command -v zplug >/dev/null 2>&1; then
        echo -e "\n${ECHO_SYM}* ${ECHO_MSG}zplug${ECHO_RST}\n"
        zplug update
    fi
    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}haskell${ECHO_RST}\n"
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}cabal${ECHO_RST}\n"
    cabal update
    cat $DOTFILES_DIR/cabal.txt | xargs -t -n1 cabal install # update cabal installed package
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}stack${ECHO_RST}\n"
    stack upgrade
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}hoogle${ECHO_RST}\n"
    hoogle generate
    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}python${ECHO_RST}\n"
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}pip3${ECHO_RST}\n"
    pip3 install -U -r ~/.pip3.txt
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}pip2${ECHO_RST}\n"
    pip2 install -U -r ~/.pip2.txt
    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}ruby${ECHO_RST}\n"
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}gem${ECHO_RST}\n"
    gem update && gem update --system
    gem cleanup
    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}npm${ECHO_RST}\n"
    npm update -g

    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}vim${ECHO_RST}\n"
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}vundle${ECHO_RST}\n"
    vim -c "execute \"PluginUpdate\" | qa"
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}ycm${ECHO_RST}\n"
    if [ "$(uname)" = Darwin ]; then
        python3 ~/.vim/bundle/YouCompleteMe/install.py --tern-completer --clang-completer --system-boost --system-libclang
    else
        python3 ~/.vim/bundle/YouCompleteMe/install.py --tern-completer --clang-completer
    fi
    cd ~/.vim/bundle/vimproc.vim/ && make && cd -

    echo -e "\nemacs' packages will be updated everytime open it.\n"

    echo -e "\n${ECHO_MSG} update end ${ECHO_RST}\n"

    unset ECHO_SYM
    unset ECHO_MSG
    unset ECHO_RST
    echo $(_current_epoch) > $CMD_CUSTOM_DIR/local/.update_epoch
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
    else
        echo "\n"
    fi
    unset whether_do_update
fi
unset update_epoch_file
unset need_update
