# dotfiles

Downloading neovim:

```bash
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim.appimage
echo export PATH=\"$PWD:$PATH\" >> ~/.bashrc
source ~/.bashrc

```

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install flake8
```

Then, in your `~/.bashrc` set `alias vim="nvim -u /path/to/dotfiles/.vimrc`. Open `vim` and run `:PlugInstall`
