#!/usr/bin/env zsh

# Exit on error
set -e

echo "Starting setup script..."

# Update package lists
sudo apt-get update

# Install necessary packages
echo "Installing basic dependencies..."
sudo apt-get install -y \
    zsh \
    git \
    curl \
    wget \
    python3-pip \
    nodejs \
    npm \
    fonts-powerline

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install Powerlevel10k theme
echo "Installing Powerlevel10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install ZSH plugins
echo "Installing ZSH plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Configure ZSH
echo "Configuring ZSH..."
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# Install Python packages
echo "Installing Python packages..."
pip3 install --upgrade pip
pip3 install flake8 pylint pytight autopep8

# Install clangd-12 and ripgrep
echo "Installing clangd-12 and ripgrep..."
sudo apt-get install -y clangd-12 ripgrep

# Install Node.js LTS
echo "Installing Node.js LTS..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Vim-plug
echo "Installing Vim-plug..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Set ZSH as default shell
echo "Setting ZSH as default shell..."
chsh -s $(which zsh)

echo "Setup completed! Please restart your terminal and run 'p10k configure' to setup Powerlevel10k theme."
