#!/usr/bin/env bash

set -euox pipefail


pacman -Syyu --noconfirm
pacman -S --noconfirm \
  ansible base-devel colordiff curl dos2unix gettext-devel git libcrypt-devel \
  mingw-w64-i686-toolchain mingw-w64-x86_64-toolchain \
  mingw-w64-clang-x86_64-clang mingw-w64-x86_64-go mingw-w64-x86_64-jq \
  ncurses-devel perl-devel python-devel ruby time tmux tree unzip wget zip zsh
pacman -Scc --noconfirm

git config --global core.autocrlf input

if python -m pip --version; then
  python -m pip install -U --no-cache-dir pip
else
  curl -SL https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
  python /tmp/get-pip.py install -U --no-cache-dir pip
fi
python -m pip install -U --no-cache-dir \
  ansible-lint autopep8 csvkit docker-compose docopt flake8 flake8-bugbear \
  flake8-isort jupyter pandas pep8-naming scipy seaborn vim-vint vulture \
  yamllint
python -m pip install -U --no-cache-dir \
  bash_kernel ggplot grip jupyter_contrib_nbextensions jupyterthemes psutil \
  pynvim scikit-learn sklearn-pandas statsmodels tqdm

curl -SL \
  https://raw.githubusercontent.com/dceoy/ansible-dev/master/roles/cli/files/zshrc \
  -o ~/.zshrc
curl -SL \
  https://raw.githubusercontent.com/dceoy/ansible-dev/master/roles/vim/files/vimrc \
  -o ~/.vimrc

curl -SL https://raw.githubusercontent.com/dceoy/install-latest-vim/master/install_latest_vim.sh \
  -o /tmp/install_latest_vim.sh
bash /tmp/install_latest_vim.sh --debug --lua --dein
