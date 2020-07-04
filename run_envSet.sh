#!/usr/bin/env bash
set -e
NUM_CORES=$(grep -c ^processor /proc/cpuinfo)

echo "Checking your OS..."
if [ ${OSTYPE} != "linux-gnu" ] || [ ${SYSTEM_BASE} != "debian" ]; then
  echo "Can't apply this script in your OS"
  exit 1
fi

echo "Now start to install working tools via apt"
# Update before installation in order to avoid that apt fail to locate
# expected package
sudo apt update
# Install the working tools
sudo apt install -y git tmux wget curl tree vim htop cmake jq openssh-server \
                    git-extras xclip python-pip
# Enhance working tools: less
sudo apt install -y libsource-highlight-common source-highlight colordiff
# For git auto-update install
sudo apt install -y libssl-dev libcurl4-openssl-dev

github_raw_url="https://raw.githubusercontent.com/"

my_config_repo="extend1994/Configs/master/"
colorBash_repo="PeterDaveHello/ColorEchoForShell/master/"
gitorg_repo="git/git/master/"
gitcompletion="contrib/completion/git-completion.bash"
diff_highlight="git/git/v2.13.2/contrib/diff-highlight/diff-highlight"
echo "Load dotfiles..."
for file in .bashrc .bash_aliases .bash_profile .gitconfig .tmux.conf\
            .vimrc .curlrc .wgetrc
do
  curl -Ss "$github_raw_url$my_config_repo$file" -o ~/$file
done
curl -Ss "$github_raw_url$colorBash_repo""dist/ColorEcho.bash" -o ~/.colorEcho
. ~/.colorEcho
curl -Ss "$github_raw_url$gitorg_repo$gitcompletion" -o ~/.git-gitcompletion
curl -Ss "$github_raw_url$diff_highlight" -o ~/.git/contrib/diff-highlight
sudo chmod 755 ~/.git/contrib/diff-highlight
echo.LightBoldGreen "dotfiles are all loaded successfully!"

nvm_repo="creationix/nvm/v0.35.3/"
echo.LightBoldYellow "Install nvm and node"
if [ ! -e "/home/$USER/.nvm/nvm.sh" ]; then
  curl -o- "$github_raw_url$nvm_repo""install.sh" | bash
fi
# Load nvm command
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
source ~/.bashrc
nvm install v10

echo.LightBoldYellow "Install useful tools..."
pip install git+https://github.com/jeffkaufman/icdiff.git
echo.LightBoldGreen "icdiff is installed! It's an improvement of \`colordiff\`."
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
sudo dpkg -i ripgrep_0.10.0_amd64.deb
echo.LightBoldGreen "rg is installed! It's an alternative of \`grep\`."
curl -LO https://github.com/sharkdp/bat/releases/download/v0.9.0/bat_0.9.0_amd64.deb
sudo dpkg -i bat_0.9.0_amd64.deb
rm -rf bat_0.9.0_amd64.deb
echo.LightBoldGreen "bat is installed! It's an alternative of \`cat\`."
curl -LO https://github.com/sharkdp/fd/releases/download/v7.2.0/fd_7.2.0_amd64.deb
sudo dpkg -i fd_7.2.0_amd64.deb
rm -rf fd_7.2.0_amd64.deb
echo.LightBoldGreen "fd is installed! It's an alternative of \`find\`."
sudo apt install -y ncdu lnav httpie
echo.LightBoldGreen "ncdu is installed! It's an alternative of \`du\`."
echo.LightBoldGreen "lnav is installed! It's a LOG file navigator."
echo.LightBoldGreen "httpie is installed! It's an alternative of \`curl\`/\`wget\`."
sudo apt install -y cargo
cargo install exa
echo "export PATH=\"~/.cargo/bin:\$PATH\"" >> ~/.bashrc
echo.LightBoldGreen "exa is installed! It's an alternative of \`ls\`"
git clone https://github.com/rupa/z ~/z
echo ". ~/z/z.sh" >> ~/.bashrc
echo.LightBoldGreen "z is installed! It makes \`cd\` better."
source ~/.bashrc

echo.LightBoldYellow "Start to set tmux and install its plugins..."
if [ ! -d "/home/$USER/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
~/.tmux/plugins/tpm/bin/install_plugins
if [ ! -d "/home/$USER/.tmux/plugins/tmux-mem-cpu-load" ]; then
  sudo apt install -y g++
  git clone https://github.com/thewtex/tmux-mem-cpu-load ~/.tmux/plugins/tmux-mem-cpu-load
fi
cd ~/.tmux/plugins/tmux-mem-cpu-load
cmake .
make -j${NUM_CORES}
sudo make -j${NUM_CORES} install

lunaterm_repo="notpratheek/vim-luna/master/"
echo.LightBoldYellow "Start to set vim and install its plugins..."
echo.LightBoldCyan "Get vim theme: luna-term"
curl -Ss "$github_raw_url$lunaterm_repo""colors/luna-term.vim" -o ~/.vim/colors/luna-term.vim
echo.LightBoldCyan "Install vim plugin manager vundle to install all plugins"
# ycm requirement
sudo apt-get install build-essential -y
# For python headers
sudo apt-get install python-dev python3-dev -y
if [ ! -d "/home/$USER/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall
# Load custom snippets
mkdir -p ~/.vim/UltiSnips
curl -Ss "$github_raw_url$my_config_repo""config-examples/UltiSnips/json.snippets" \
         -o ~/.vim/UltiSnips/json.snippets
echo.LightBoldMagenta "(Re)Build YouCompleteMe [default Y/n]"
read ycm_flag
[ -z $ycm_flag ] && ycm_flag="Y" || ycm_flag="N"
if [ "$ycm_flag" = "Y" -o $ycm_flag = "y" ]; then
  cd ~/.vim/bundle/YouCompleteMe
  ./install.py --clang-completer --js-completer
fi

echo.LightBoldYellow "Install fzf command-line fuzzy finder [default Y/n]"
read fzf_flag
[ -z $fzf_flag ] && fzf_flag="Y" || fzf_flag="N"
if [ "$fzf_flag" = "Y" -o $fzf_flag = "y" ]; then
  if [ ! -d "/home/$USER/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  fi
  ~/.fzf/install
fi

echo.LightBoldYellow "Enter yes to install cdnjs related environment [default Y/n]"
read cdnjs_flag
[ -z $cdnjs_flag ] && cdnjs_flag="Y" || cdnjs_flag="N"
if [ "$cdnjs_flag" = "Y" -o "$cdnjs_flag" = "y" ]; then
  # Initilize cdnjs repository
  if [ ! -d "/home/$USER/repos/cdnjs" ]; then
    git init ~/repos/cdnjs && cd ~/repos/cdnjs
    git config core.sparseCheckout true
    curl -Ss "$github_raw_url$my_config_repo""config-examples/sparse-checkout" -o \
    ~/repos/cdnjs/.git/info/sparse-checkout
    git remote add origin git://cdnjs.peterdavehello.org/cdnjs
    git remote add g-origin git@github.com:cdnjs/cdnjs.git
    git remote add myorigin git@github.com:extend1994/cdnjs.git
  else
    cd ~/repos/cdnjs
  fi
  echo.LightBoldOrange "Start to pull cdnjs repo, it takes long time..."
  git pull origin master --depth 10
  npm install
  echo.LightBoldCyan "Get git auto-update tool"
  if [ ! -d "/home/$USER/repos/autoupdate" ]; then
    git clone https://github.com/cdnjs/autoupdate.git ~/repos/autoupdate
  fi
  cd ~/repos/autoupdate
  npm install
  echo.LightBoldCyan "Get minifying tool"
  if [ ! -d "/home/$USER/repos/web-minify-helper" ]; then
    git clone --recursive https://github.com/PeterDaveHello/web-minify-helper.git \
                          ~/repos/web-minify-helper
  fi
  cd ~/repos/web-minify-helper
  git submodule update --init
  npm install
fi

echo.LightBoldYellow "Get my own working tools"
git clone https://github.com/extend1994/Tools.git ~/repos/Tools
npm install --global tldr diff-so-fancy
echo.LightBoldGreen "All done!!!"
