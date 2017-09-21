# Install the required tools
sudo apt install git tmux nvm -y
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
