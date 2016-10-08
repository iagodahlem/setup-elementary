#!/bin/sh

# Ask for the administrator password upfront
sudo -v

# Icons
# ----------------------------------

ARROW="→"
CHECK="✔"
CLOSE="✗"
HEART="♥"

# Loggers
# ----------------------------------

function msg() {
	echo "\033[0;37m$1\033[0m";
}

function msg_bold() {
	echo "\033[1;34m$1\033[0m";
}

function msg_ok() {
	echo "$ARROW\033[1;32m  $1 $CHECK\033[0m";
}

# Conditions
# ----------------------------------

function has() {
	[[ -x "$(command -v "$1")" ]];
}

function has_not() {
	! has "$1" ;
}

function has_dir() {
	[[ -d "$1" ]];
}

function has_not_dir() {
	! has_dir "$1" ;
}

function hello() {
	msg ""
	msg_bold "   _____      _                 ______ _                           _                   "
	msg_bold "  / ____|    | |               |  ____| |                         | |                  "
	msg_bold " | (___   ___| |_ _   _ _ __   | |__  | | ___ _ __ ___   ___ _ __ | |_ __ _ _ __ _   _ "
	msg_bold "  \___ \ / _ \ __| | | |  _ \  |  __| | |/ _ \  _ ` _ \ / _ \  _ \| __/ _` |  __| | | |"
	msg_bold "  ____) |  __/ |_| |_| | |_) | | |____| |  __/ | | | | |  __/ | | | || (_| | |  | |_| |"
	msg_bold " |_____/ \___|\__|\__,_| .__/  |______|_|\___|_| |_| |_|\___|_| |_|\__\__,_|_|   \__, |"
	msg_bold "                       | |                                                        __/ |"
	msg_bold "                       |_|                                                       |___/ "
	msg ""
	msg " \e[3mMade by @iagodahlem with \033[1;31m♥\033[0m "
	msg ""
	msg " ------------------------------- "
	msg ""
}

hello

# General installs
sudo apt-get install -y \
	build-essential \
	curl \
	gnome-disk-utility \
	gnome-system-monitor \
	indicator-multiload \
	openssh-server \
	preload \
	smbclient \
	software-properties-gtk \
	ubuntu-restricted-extras \
	vim \
	xclip \
	xsel
msg_ok "build-essential"
msg_ok "curl"
msg_ok "gnome-disk-utility"
msg_ok "gnome-system-monitor"
msg_ok "indicator-multiload"
msg_ok "openssh-server"
msg_ok "preload"
msg_ok "smbclient"
msg_ok "software-properties-gtk"
msg_ok "ubuntu-restricted-extras"
msg_ok "vim"
msg_ok "xclip"
msg_ok "xsel"

# Caffeine
# if has_not caffeine; then
# 	sudo apt-add reposiory -y ppa:caffeine-developers/ppa -y
# 	sudo apt-get update
# 	sudo apt-get install caffeine -y
# fi
# msg_ok "caffeine"

# Dropbox
if has_not_dir "$HOME/.dropbox"; then
	git clone https://github.com/zant95/elementary-dropbox /tmp/elementary-dropbox
	bash /tmp/elementary-dropbox/install.sh
fi
msg_ok "dropbox"

# Chrome Stable
if has_not google-chrome-stable; then
	wget -O ~/Downloads/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg --force-depends -i ~/Downloads/chrome.deb
	sudo apt-get install -fy
	rm ~/Downloads/chrome.deb
fi
msg_ok "chrome stable"

# Chromium Browser
if has_not chromium-browser; then
	sudo apt-get install chromium-browser -y
fi
msg_ok "chromium browser"

# Docker
if has_not docker; then
	sudo apt-get update
	sudo apt-get install apt-transport-https ca-certificates -y
	sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

	echo deb https://apt.dockerproject.org/repo ubuntu-xenial main | sudo tee /etc/apt/sources.list.d/docker.list
	sudo apt-get update
	sudo apt-get purge lxc-docker -y
	apt-cache policy docker-engine
	sudo apt-get install linux-image-extra-$(uname -r) -y
	sudo apt-get update
	sudo apt-get install docker-engine -y
	sudo service docker start
	sudo groupadd docker
	sudo usermod -aG docker iago
fi
msg_ok "docker"

# Elementary Plus
if has_not elementaryplus-configurator; then
	sudo add-apt-repository ppa:cybre/elementaryplus -y
	sudo apt-get update
	sudo apt-get install elementaryplus -y
fi
msg_ok "elementary plus"

# Gimp
if has_not gimp; then
	sudo apt-get install gimp -y
fi
msg_ok "gimp"

# Firefox Aurora
if has_not firefox; then
	sudo add-apt-repository ppa:ubuntu-mozilla-daily/firefox-aurora
	sudo apt-get update
	sudo apt-get install firefox
fi
msg_ok "firefox aurora"

# Java
if has_not java; then
	sudo add-apt-repository -y ppa:webupd8team/java
	sudo apt-get update
	sudo apt-get install oracle-java8-installer
	sudo apt-get install oracle-java8-set-default
fi
msg_ok "java 8"

# Maven
if has_not mvn; then
	sudo apt-get install maven
fi
msg_ok "maven"

# NVM
if has_not_dir "$HOME/.nvm"; then
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
	source ~/.zshrc
	nvm install node
	nvm use node
	nvm alias default node

	npm i -g \
		npm \
		babel \
		bower \
		empty-trash-cli \
		eslint \
		grunt-cli \
		gulp-cli \
		stylelint \
		trash-cli \
		webpack \
		yo
fi
msg_ok "nvm, node, npm modules"

# Oh My ZSH
if has_not_dir "$HOME/.oh-my-zsh"; then
	chsh -s /usr/bin/zsh
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

	# Plugins
	git clone https://github.com/wbinglee/zsh-wakatime.git ~/.custom/plugins/zsh-wakatime
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.custom/plugins/zsh-syntax-highlighting

	# Themes
	wget https://raw.githubusercontent.com/dracula/zsh/master/dracula.zsh-theme -O ~/.custom/themes/dracula.zsh-theme
fi
msg_ok "oh-my-zsh"

# Opera Developer
if has_not opera-developer; then
	wget -O ~/Downloads/opera.deb http://download2.operacdn.com/pub/opera-developer/41.0.2329.0/linux/opera-developer_41.0.2329.0_amd64.deb
	sudo dpkg --force-depends -i ~/Downloads/opera.deb
	sudo apt-get install -fy
	rm ~/Downloads/opera.deb
fi
msg_ok "opera developer"

# Pip
if has_not pip; then
	sudo apt-get install -y \
		python-dev \
		python-pip \
		python-software-properties

	sudo pip install --upgrade \
		pip \
		virtualenv

	sudo pip install \
		psutil \
		Pygments \
		thefuck \
		wakatime
fi
msg_ok "pip"

# Redshift
if has_not redshift; then
	sudo apt-get install -y \
		redshift \
		redshift-gtk
fi
msg_ok "redshift"

# rbenv
if has_not_dir "$HOME/.rbenv"; then
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
		libgdbm-dev

	git clone https://github.com/rbenv/rbenv.git ~/.rbenv
	cd ~/.rbenv && src/configure && make -C src
	cd -

	git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi
msg_ok "rbenv, ruby-build"

# Skype
if has_not skype; then
	sudo sh -c 'echo "deb http://archive.canonical.com/ubuntu trusty partner" >> /etc/apt/sources.list.d/canonical_partner.list'
	sudo apt-get update
	sudo apt-get install -y skype
fi
msg_ok "skype"

# Slack
if has_not slack; then
	wget -O ~/Downloads/slack.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-2.1.0-amd64.deb
	sudo dpkg --force-depends -i ~/Downloads/slack.deb
	sudo apt-get install -fy
	rm ~/Downloads/slack.deb
fi
msg_ok "slack"

# Spotify
if has_not spotify; then
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update
	sudo apt-get install spotify-client -y --allow-unauthenticated
fi
msg_ok "spotify"

# Sublime Text
if has_not subl; then
	sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
	sudo apt-get update
	sudo apt-get -y install sublime-text-installer
fi
msg_ok "sublime"

# Shutter
if has_not shutter; then
	sudo apt-get -y install shutter
fi
msg_ok "shutter"

# Tlp
if has_not tlp; then
	sudo add-apt-repository ppa:linrunner/tlp -y
	sudo apt-get update
	sudo apt-get install tlp tlp-rdw -y
	sudo tlp start
fi
msg_ok "tlp"

# Virtualbox
if has_not virtualbox; then
	sudo apt-get install -y \
		virtualbox \
		virtualbox-dkms
fi
msg_ok "virtualbox"

# Cleanup
sudo apt-get purge -y \

sudo apt-get autoclean &> /dev/null -y
sudo apt-get autoremove &> /dev/null -y

sudo chmod 744 /usr/lib/gvfs/gvfsd-smb-browse

source ~/.zshrc

msg ""
