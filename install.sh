#!/bin/bash
set -eo pipefail

# has command?
has() {
  [[ -x "$(command -v "$1")" ]];
}

# doesn't have command?
has_not() {
  ! has "$1" ;
}

installed() {
  echo $1" successfully installed!"
}

sudo apt update
sudo apt install -y \
	ubuntu-restricted-extras \
	htop \
	zsh \
	terminator \
	curl \
	git git-core \
	vim-gnome

installed "ubuntu update"
installed "htop"
installed "zsh"
installed "curl"
installed "terminator"
installed "git"
installed "vim"

if has_not google-chrome-stable; then
	wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg --force-depends -i chrome.deb
	sudo apt-get install -fy
	rm chrome.deb
fi
installed "Google Chrome"

if has_not docker; then
	sudo apt-get install apt-transport-https ca-certificates linux-image-extra-$(uname -r) -y
	sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
	sudo sh -c "echo 'deb https://apt.dockerproject.org/repo ubuntu-$(lsb_release -sc) main' | cat > /etc/apt/sources.list.d/docker.list"
	sudo apt-get update
	sudo apt-get purge lxc-docker
	sudo apt-get install docker-engine -y
	sudo service docker start
	sudo groupadd docker
	sudo usermod -aG docker $(id -un)
fi
installed "Docker"

if ! [[ -d "$HOME/.nvm" ]]; then
  NODE_VERSION=8.11.3
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
  source ~/.bashrc
  nvm install $NODE_VERSION
  nvm use $NODE_VERSION
  nvm alias default $NODE_VERSION
fi
installed "NVM"


if has_not php; then
  sudo apt-get install -y php-pear \
    php5-cli \
    php5-curl \
    php5-dev \
    php5-gd \
    php5-imagick \
    php5-imap \
    php5-mcrypt \
    php5-pspell \
    php5-tidy \
    php5-xmlrpc \
    php5-mysql \
    libapache2-mod-php5
fi
installed "PHP"

if has_not composer; then
  curl -sS https://getcomposer.org/installer | php
  sudo mv composer.phar /usr/local/bin/composer
fi
installed "Composer"


if ! [[ -d "$HOME/.oh-my-zsh" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
installed "OH my zsh"

if has_not code; then
  sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  sudo curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
  sudo apt update
  sudo apt install code
if

# Clean up
sudo apt-get autoclean -y
sudo apt-get autoremove -y

echo "Installed finished"
