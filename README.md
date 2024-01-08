# dotfiles

Downloading neovim:

```bash
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim.appimage
echo export PATH=\"$PWD:$PATH\" >> ~/.bashrc
source ~/.bashrc

```

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
pip3 install flake8
```

`mv nvim.appimage ~/.local/bin/vim`.

Then, in your `~/.bashrc` set `alias vim="nvim -u /path/to/dotfiles/.vimrc`. Open `vim` and run `:PlugInstall`
