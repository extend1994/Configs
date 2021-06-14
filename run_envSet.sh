#!/usr/bin/env bash
set -e
NUM_CORES=$(grep -c ^processor /proc/cpuinfo)
BASH_VARIABLE=$(compgen -v)

echo "Checking your OS..."
if [ "${OSTYPE}" != "linux-gnu" ] || [[ "${BASH_VARIABLE[@]}" =~ "SYSTEM_BASE" ]] && [ ${SYSTEM_BASE} != "debian" ];  then
  echo "Can't apply this script in your OS"
  exit 1
fi

echo "Prepare necessary apt repositories for latest vim & cmake"
sudo add-apt-repository ppa:jonathonf/vim
sudo apt -qq -y install wget
wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null
sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'

echo "Now start to install working tools via apt"
# Update before installation in order to avoid that apt fail to locate
# expected package
echo "Executing apt update..."
sudo apt -qq update
# Prepare for cmake
sudo apt -qq -y install apt-transport-https ca-certificates gnupg software-properties-common
# Install the working tools
echo "Executing apt install..."
sudo apt -qq install -y git tmux curl tree vim htop cmake jq openssh-server \
                    git-extras xclip python-pip
# Enhance working tools: less
sudo apt -qq install -y libsource-highlight-common source-highlight colordiff
# For git auto-update install
sudo apt -qq install -y libssl-dev libcurl4-openssl-dev

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

nvm_repo="creationix/nvm/v0.38.0/"
echo.LightBoldYellow "Install nvm and node"
if [ ! -e "/home/$USER/.nvm/nvm.sh" ]; then
  curl -o- "$github_raw_url$nvm_repo""install.sh" | bash
fi
# Load nvm command
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
source ~/.bashrc
nvm install v12

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
sudo apt -qq install -y ncdu lnav httpie
echo.LightBoldGreen "ncdu is installed! It's an alternative of \`du\`."
echo.LightBoldGreen "lnav is installed! It's a LOG file navigator."
echo.LightBoldGreen "httpie is installed! It's an alternative of \`curl\`/\`wget\`."
sudo apt -qq install -y cargo
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
  sudo apt -qq install -y g++
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
sudo apt-get -qq install build-essential -y
# For python headers
sudo apt-get -qq install python-dev python3-dev -y
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
[ -z $ycm_flag ] && ycm_flag="Y"
if [[ "$ycm_flag" =~ (Y|y|yes) ]]; then
  cd ~/.vim/bundle/YouCompleteMe
  ./install.py --clang-completer --js-completer
fi

echo.LightBoldYellow "Install fzf command-line fuzzy finder [default Y/n]"
read fzf_flag
[ -z $fzf_flag ] && fzf_flag="Y"
if [[ "$fzf_flag" =~ (Y|y|yes) ]]; then
  if [ ! -d "/home/$USER/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  fi
  ~/.fzf/install
fi

echo.LightBoldYellow "Get my own working tools"
git clone https://github.com/extend1994/Tools.git ~/repos/Tools
npm install --global tldr diff-so-fancy
echo.LightBoldGreen "All done!!!"
