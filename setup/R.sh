echo_info "** setup R"
ln -f -s $script_dir/R.txt ~/.R.txt

if command -v R >/dev/null 2>&1; then
    echo_info "*** setup R"
    if [ $(uname) = Darwin ]; then
        cat $script_dir/R.txt | xargs -n1 -I "{}"  R --slave --quiet -e "install.packages('{}')"
    else
        cat $script_dir/R.txt | xargs -n1 -I "{}"  sudo R --slave --quiet -e "install.packages('{}')"
    fi
else
    echo_warn "!!! ERROR: NO R"
    exit 1
fi
