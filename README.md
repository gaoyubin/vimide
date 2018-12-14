An automatic configuration program for vim
===============================================i

## install
### Ubuntu

- 版本要求

`ubuntu16.04`及其以上系统。

- 安装vimplus(建议在普通用户下安装)

		``bash
		mv ~/.vim ~/.vim.backup
		cp ~/.vimrc  ~/.vimrc.backup 
		git clone https://github.com/gaoyubin/vimide.git ~/.vim
		cp ~/.vim/vimrc  ~/.vimrc   
	    ``
- 注意事项
安装tern-for-vim的时候，注意要重新编译ycm(./install.py --tern-complete),然后完成后需要在项目的根目录建立 .tern-project 文件，
，还要进行 npm install 操作
