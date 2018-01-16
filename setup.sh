#!/bin/bash

DIR=$(dirname $0)

git clone git@github.com:iagodahlem/scripts.git &> /dev/null
source $DIR/scripts/index.sh

banner() {
  log  ""
  bold "                _                 "
  bold "               | |                "
  bold "       ___  ___| |_ _   _ _ __    "
  bold "      / __|/ _ \ __| | | | '_ \   "
  bold "      \__ \  __/ |_| |_| | |_) |  "
  bold "      |___/\___|\__|\__,_| .__/   "
  bold "                         | |      "
  bold "                         |_|      "
  log  ""
  log  "      Made by @iagodahlem with $(heart)"
  log  ""
  log  "  -----------------------------------"
  log  ""
}

banner

# ask for the administrator password upfront
sudo -v

arrow "purge default apps"
sudo apt-get purge -y \
  epiphany-browser \
  gnome-orca \
  pantheon-mail \
  simple-scan \
  > /dev/null
check "default apps purged"

arrow "update softwares"
sudo apt-get update > /dev/null
sudo apt-get upgrade -y > /dev/null
sudo apt-get dist-upgrade > /dev/null
check "softwares updated"

# utilities
arrow "install utilities (curl, htop, xclip, etc...)"
sudo apt-get install -y \
  apt-transport-https \
  build-essential \
  curl \
  htop \
  preload \
  software-properties-gtk \
  ubuntu-restricted-extras \
  xclip \
  > /dev/null
check "utilities installed"

# browsers
arrow "install browsers"
sudo apt-get install -y \
  chromium-browser \
  firefox \
  > /dev/null
check "browsers installed"

# syspeek
arrow "install syspeek"
sudo add-apt-repository -y ppa:nilarimogard/webupd8 > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install syspeek -y > /dev/null
check "syspeek installed"

# elementaryplus
arrow "insall elementaryplus"
sudo add-apt-repository -y ppa:cybre/elementaryplus > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install elementaryplus -y > /dev/null
check "elementaryplus installed"

# java / maven
arrow "install java/maven"
sudo add-apt-repository -y ppa:webupd8team/java > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install -y \
  oracle-java8-installer \
  oracle-java8-set-default \
  maven \
  > /dev/null
check "java/maven installed"

# redshift
arrow "install redshift"
sudo apt-get install -y \
  redshift \
  redshift-gtk \
  > /dev/null
check "redshift installed"

# subl
arrow "install sublime"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install -y sublime-text > /dev/null
check "sublime installed"

# pip
arrow "install pip"
sudo apt-get install -y \
  python-dev \
  python-pip \
  python-software-properties \
  > /dev/null
sudo pip install --upgrade \
  pip \
  virtualenv \
  > /dev/null
sudo pip install \
  psutil \
  Pygments \
  thefuck \
  wakatime \
  > /dev/null
check "pip installed"

# rbenv
arrow "install rbenv"
sudo apt-get install -y \
  autoconf \
  bison \
  build-essential \
  libssl-dev \
  libyaml-dev \
  libreadline6-dev \
  zlib1g-dev \
  libncurses5-dev \
  libffi-dev \
  libgdbm3 \
  libgdbm-dev \
  > /dev/null
git clone https://github.com/rbenv/rbenv.git ~/.rbenv > /dev/null
cd ~/.rbenv && src/configure
make -C src > /dev/null
cd -
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build > /dev/null
check "rbenv installed"

# tlp
arrow "install tlp"
sudo add-apt-repository -y ppa:linrunner/tlp > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install -y tlp tlp-rdw > /dev/null
sudo tlp start > /dev/null
check "tlp installed"

# spotify
arrow "install spotify"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410 > /dev/null
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install -y spotify-client > /dev/null
check "spotify installed"

# git
arrow "install git"
sudo apt-get install -y git> /dev/null
check "git installed"

# zsh / oh-my-zsh
arrow "install zsh / oh-my-zsh"
sudo apt-get install -y zsh > /dev/null
chsh -s $(which zsh) > /dev/null
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" > /dev/null
# plugins
git clone https://github.com/wbinglee/zsh-wakatime.git ~/.custom/plugins/zsh-wakatime > /dev/null
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.custom/plugins/zsh-syntax-highlighting > /dev/null
# themes
wget https://raw.githubusercontent.com/dracula/zsh/22058079469b74af07f1f4984df505f9b5156c1f/dracula.zsh-theme \
  -O ~/.custom/themes/dracula.zsh-theme \
  > /dev/null
check "zsh / oh-my-zsh installed"

# nvm
arrow "install nvm"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash > /dev/null
check "nvm installed"

# yarn
arrow "install yarn"
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - > /dev/null
echo "deb http://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install -y  yarn > /dev/null
check "yarn installed"

# vim
arrow "install vim"
sudo apt-get install -y vim > /dev/null
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim > /dev/null
check "vim installed"

# tmux
arrow "install tmux"
sudo apt install -y \
  automake \
  build-essential \
  pkg-config \
  libevent-dev \
  libncurses5-dev \
  > /dev/null

rm -fr /tmp/tmux

git clone https://github.com/tmux/tmux.git /tmp/tmux > /dev/null

cd /tmp/tmux
sh autogen.sh > /dev/null
./configure > /dev/null
make > /dev/null
sudo make install > /dev/null
cd -
rm -fr /tmp/tmux

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
check "tmux installed"

# docker
arrow "install docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - > /dev/null
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  xenial \
  stable" \
  > /dev/null
sudo apt-get update > /dev/null
sudo apt-get install -y docker-ce > /dev/null
sudo groupadd docker
sudo usermod -aG docker $USER

sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose > /dev/null
sudo chmod +x /usr/local/bin/docker-compose
check "docker installed"

# dropbox
arrow "install dropbox"
git clone https://github.com/zant95/elementary-dropbox /tmp/elementary-dropbox > /dev/null
bash /tmp/elementary-dropbox/install.sh
check "dropbox installed"

arrow "installing xcape"
sudo apt-get install -y \
  gcc \
  make \
  pkg-config \
  libx11-dev \
  libxtst-dev \
  libxi-dev \
  > /dev/null
git clone https://github.com/alols/xcape.git ~/softwares/xcape > /dev/null
cd ~/softwares/xcape
make > /dev/null
sudo make install > /dev/null
cd -
check "xcape installed"

# ananicy
arrow "install ananicy"
git clone https://github.com/Nefelim4ag/Ananicy.git > /dev/null
./Ananicy/package.sh debian > /dev/null
sudo dpkg -i ./Ananicy/ananicy-*.deb > /dev/null
rm -rf Ananicy
check "ananicy installed"

# firacode
arrow "install firacode"
mkdir -p ~/.local/share/fonts
for type in Bold Light Medium Regular Retina; do
  wget -O ~/.local/share/fonts/FiraCode-${type}.ttf \
    "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true"; \
    > /dev/null
done
fc-cache -f > /dev/null
check "firacode installed"

# vm
arrow "configure vm options"
sudo tee -a /etc/sysctl.d/99-sysctl.conf <<-EOF
vm.swappiness=1
vm.vfs_cache_pressure=50
vm.dirty_background_bytes=16777216
vm.dirty_bytes=50331648
EOF
check "vm configured"

arrow "install dotfiles"
git clone git@github.com:iagodahlem/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup.sh
check "dotfiles installed"

arrow "remove unnecessary packages"
sudo apt-get autoremove -y
check "packages removed"

# clean up scripts
rm -rf scripts
