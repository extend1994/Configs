# Install the required tools
sudo apt install git tmux wget curl -y
# 0.33.8 is the latest version of nvm on Dec 15, 2017
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
# Use node v4 managed by nvm
sudo nvm install v4
# Use the referenced env setting from PeterDaveHello
curl -Lo- https://goo.gl/FGs2Fu | bas
# Use my own git config
# Initilize cdnjs repository
git init cdnjs && cd cdnjs
git config core.sparseCheckout true
git remote add origin git://cdnjs.peterdavehello.org/cdnjs
git remote add g-origin https://github.com/cdnjs/cdnjs.git
git remote add myorigin git@github.com:extend1994/cdnjs.git
git pull origin master --depth 10
npm install
# Get the git auto-update repository
cd ../
git clone https://github.com/cdnjs/autoupdate.git && cd autoupdate
npm install
# Get minifying tool
cd ../
git clone https://github.com/PeterDaveHello/web-minify-helper.git && cd web-minify-helper
git submodule update --init
npm install
# Get tools for adding library & reviewing pull requests
cd ../
git clone https://github.com/extend1994/Tools.git
