## Debian 10
### Internet
#### Static IP
Switch to root user, then edit the `/etc/network/interfaces` file.
```Bash
su; vi /etc/network/interfaces
```
```
# The primary network interface
allow-hotplug ens192
iface ens192 inet static
        address 10.10.X.Y
        netmask 255.255.255.0
        gateway 10.10.X.Z
        dns-nameservers 8.8.8.8
```
Restart network interface again.
```Bash
/etc/init.d/networking restart
/sbin/ifup ens192
```
#### Change Packages Source Path

### Softwares
#### Sudo
```Bash
su; apt install sudo
/sbin/adduser $USERNAME sudo
# Logout & login
sudo echo 'Hello, world'
```
#### Git
```Bash
sudo apt install tree, unzip, git, neovim, tmux
# Download configure files from cloud
git clone https://gitee.com/jnkuo/devEnv; cd devEnv

# Install configure files
cp user_root/bashrc ~/.bashrc
cp user_root/gitconfig ~/.gitconfig
cp user_root/tmux.conf ~/.tmux.conf
# Vim: vimrc
mkdir -p ~/.config/nvim
cp user_root/init.vim ~/.config/nvim/

# sudo apt install fonts-powerline
# Download & install powerline-fonts for Windows
# from https://github.com/powerline/fonts
```
#### NeoVim
```Bash
# Check global/universal-ctags version
# sudo apt policy global, universal-ctags

sudo apt install global, python-pygments, universal-ctags
# Added gtags.conf into /etc/gtags.conf
```
Open `nvim` and install plugs.
```vim
:PlugInstall
```

### About
+ [Why choose .config/.local?](https://askubuntu.com/questions/14535/whats-the-local-folder-for-in-my-home-directory)

### Troubleshooting
+ [ERROR: gutentags: gtags-cscope job failed, returned: 1](https://github.com/skywind3000/gutentags_plus#troubleshooting)
