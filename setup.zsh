#!/usr/bin/env zsh

# 安装额外的 oh-my-zsh 插件
echo "Installing additional oh-my-zsh plugins..."
sudo apt-get install -y autojump
echo "source /usr/share/autojump/autojump.zsh" >> ~/.zshrc

# 安装 Coc.nvim 的依赖
echo "Installing Coc.nvim dependencies..."
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g yarn

# 安装 coc 扩展
echo "Installing Coc extensions..."
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}' > package.json
fi
npm install \
    coc-json \
    coc-pyright \
    coc-clangd \
    coc-snippets \
    coc-pairs \
    --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

# 创建 Coc 配置文件
echo "Creating Coc configuration..."
mkdir -p ~/.config/nvim
cat > ~/.config/nvim/coc-settings.json << 'EOL'
{
  "suggest.noselect": false,
  "suggest.enablePreselect": false,
  "suggest.triggerAfterInsertEnter": true,
  "suggest.timeout": 5000,
  "suggest.enablePreview": true,
  "suggest.floatEnable": true,
  "suggest.detailField": "preview",
  "suggest.snippetIndicator": "🔸",
  "diagnostic.errorSign": "●",
  "diagnostic.warningSign": "⚠",
  "diagnostic.infoSign": "•",
  "diagnostic.checkCurrentLine": true,
  "python.linting.enabled": true,
  "python.linting.pylintEnabled": true,
  "python.linting.flake8Enabled": true,
  "clangd.path": "/usr/bin/clangd-12"
}
EOL

# 安装 fzf 工具
echo "Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# 创建 vim 颜色主题目录
echo "Setting up Vim color scheme..."
mkdir -p ~/.vim/colors

# 添加一些有用的 zsh aliases
echo "Adding useful aliases..."
cat >> ~/.zshrc << 'EOL'

# Useful aliases
alias zshconfig="vim ~/.zshrc"
alias vimconfig="vim ~/.vimrc"
alias update="sudo apt-get update && sudo apt-get upgrade"
alias c="clear"
alias ll="ls -la"
alias ..="cd .."
alias ...="cd ../.."
alias reload="source ~/.zshrc"
alias ports="netstat -tulanp"
alias h="history"
alias j="jobs -l"
alias mkdir="mkdir -pv"

# Git aliases
alias gst="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gd="git diff"
alias gl="git log --oneline"
EOL

# 设置历史记录配置
echo "Configuring command history..."
cat >> ~/.zshrc << 'EOL'

# History configuration
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
EOL

echo "Setup completed! Please restart your terminal for changes to take effect."
