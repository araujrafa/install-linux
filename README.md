# Linux Softwares e dicas
> Script shell para instalar as principais programas que utilizo no linux.
## Como usar
**Debian:**
```console
bash -c "$(wget -O - https://raw.githubusercontent.com/araujrafa/install-linux/master/install.sh)"
```

## Softwares e apps que serão instalados
- htop
- zsh
- terminator
- curl
- git
- vim
- Google Chrome
- docker
- Node
- Nvm
- Php
- Composer
- OH my zsh

## Depois da instalação
**Configure o GIT**
```console
git config --global user.email "your@email"
git config --global user.name "Your name"
```


## Comandos comuns

**Limpar swap**
```console
sudo swapoff -a
sudo swapon -a
```

**Descobrir seu ip**
```
ip addr show
...
2: <BROADCAST, MULTICAST...>
inet IP_NUMBER/
```

## Softwares e soluções encontradas

**Ativar videos HTML5 MP4 no vivaldi**
```console
https://gist.github.com/ruario/bec42d156d30affef655#file-latest-proprietary-media-sh
```

## License

[MIT] Rafael Araujo
