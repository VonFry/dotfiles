echo_info "* system is Darwin"
echo_info "** setup brew and a lot of software"
# cmd line tools
sudo chown $(whoami) -R /usr/local/share/man
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

cd "$(brew --repo)"
git remote set-url origin https://mirrors.ustc.edu.cn/brew.git
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git
cd "$(brew --repo)"/Library/Taps/caskroom/homebrew-cask
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

brew update && brew upgrade
brew install caskroom/cask/brew-cask

# shell
brew install gnu-sed gnu-tar unzip unrar
brew install gpg gpg-agent
brew install zsh wget git git-extras git-flow tig
brew install fzf && /usr/local/opt/fzf/install
brew install thefuck
brew install autojump
brew install googler
brew install htop
brew install lolcat                        # colorful print
brew install cloc                          # code statistics
brew install tree uchardet                 # file browser
brew install colordiff
brew install fortune cmatrix figlet        # 诗词，代码雨，ascii-art

# C & Cpp libs
brew install gcc --with-jit --with-nls
brew install llvm --with-lldb --with-ocaml --with-python --with-toolchain # This is a dependence for other app(i.e. rtags), and use it insteaded of system llvm(xcode).
brew install scons # a cross build tools
brew install gdb --with-all-targets --with-python
brew install cmake --with-completion
brew install ninja
brew install poco boost swig
brew install boost-python --with-python3

# C & Cpp developing tools
brew tap universal-ctags/universal-ctags && brew install --HEAD universal-ctags
brew install global --with-ctags --with-pygments --with-sqlite3
brew install rtags
brew install cscope
brew install doxygen --with-doxywizard

# code search
brew install ack the_silver_searcher awk gawk

# lang
brew install ghc
brew install cabal-install haskell-stack
brew install ruby --with-doc --with-gdbm --with-gmp --with-libffi
brew install rbenv
brew install clisp sbcl
brew install ocaml opam
brew install python3 python
brew install go node
brew install sqlite mysql postgresql redis # database
brew install poppler                       # pdf generator
brew install pandoc                        # markdown
brew cask install mactex                   # providing tex basic tools
brew cask install texstudio                # a tex ide
brew cask install java
brew install ispell                        # emacs flyspell dependency
brew install shellcheck

# system tool
brew install wireshark                     # web package catch

# chat
brew cask install gitter
brew install weechat --with-ruby --with-python --with-perl --with-curl --with-lua

# editor
brew install editorconfig
brew install macvim --with-lua --with-python3 --with-override-system-vim
brew install neovim
brew install emacs --with-cocoa --with-gnutls --with-imagemagick --with-librsvg --with-mailutils --with-dbus
sudo ln -f -s $script_dir/etc/motd /etc/motd

# life
brew cask install iina # video
brew install axel # http download
brew cask install deluge # torrent
brew cask install intel-power-gadget # cpu monitor

# quicklook
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package quicklookase qlvideo
brew cask install provisionql
brew cask install quicklook-pat

brew services start dbus
# My emacs cunfigure has a auto-upgrade everytime opening it, so start it by ourselves is possibly better.
brew services start emacs
brew services start rtags

echo_info "*** Here are some useful tools for mac.
See:
https://github.com/sindresorhus/quick-look-plugins
https://github.com/zenorocha/alfred-workflows"
