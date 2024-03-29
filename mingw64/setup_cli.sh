#!/usr/bin/env bash

set -euox pipefail

WD="${PWD}"

pacman -Syyuu --noconfirm
pacman -S --noconfirm --needed \
  colordiff mingw-w64-x86_64-7zip mingw-w64-x86_64-autotools \
  mingw-w64-x86_64-cmake mingw-w64-x86_64-curl mingw-w64-x86_64-file \
  mingw-w64-x86_64-go mingw-w64-x86_64-jq mingw-w64-x86_64-nodejs \
  mingw-w64-x86_64-perl mingw-w64-x86_64-python-cryptography \
  mingw-w64-x86_64-python-greenlet mingw-w64-x86_64-python-jupyter_notebook \
  mingw-w64-x86_64-python-pandas mingw-w64-x86_64-python-psutil \
  mingw-w64-x86_64-python-scikit-learn mingw-w64-x86_64-python-scipy \
  mingw-w64-x86_64-python-seaborn mingw-w64-x86_64-python-sqlalchemy \
  mingw-w64-x86_64-python-statsmodels mingw-w64-x86_64-ruby \
  mingw-w64-x86_64-sed mingw-w64-x86_64-toolchain mingw-w64-x86_64-tzdata \
  mingw-w64-x86_64-wget2 ncurses-devel time tmux tree zsh
pacman -Sc --noconfirm

git config --global core.autocrlf false
[[ -d '/usr/local/bin' ]] || mkdir -p /usr/local/bin
[[ -d '/usr/local/src' ]] || mkdir -p /usr/local/src

if [[ -d '/usr/local/src/print-github-tags' ]]; then
  cd /usr/local/src/print-github-tags
  git pull --prune
  cd "${WD}"
else
  cd /usr/local/src
  git clone --depth 1 https://github.com/dceoy/print-github-tags.git
  cd /usr/local/bin
  ln -sf ../src/print-github-tags/print-github-tags .
  cd "${WD}"
fi

if [[ -d '/usr/local/src/git-rewind-days' ]]; then
  cd /usr/local/src/git-rewind-days
  git pull --prune
  cd "${WD}"
else
  cd /usr/local/src
  git clone --depth 1 https://github.com/dceoy/git-rewind-days.git
  cd "${WD}"
fi

if [[ ! -d '/usr/local/src/nkf' ]]; then
  print-github-tags --latest --tar nurse/nkf \
    | xargs -I{} curl -SL -o /tmp/nkf.tar.gz {}
  tar xvf /tmp/nkf.tar.gz -C /usr/local/src
  mv /usr/local/src/nkf-* /usr/local/src/nkf
  cd /usr/local/src/nkf
  make && make install
  rm -f /tmp/nkf.tar.gz
  cd "${WD}"
fi

if [[ ! -d '/usr/local/src/shellcheck' ]]; then
  print-github-tags --latest koalaman/shellcheck \
    | xargs -I{} curl -SL -o /tmp/shellcheck.zip \
      https://github.com/koalaman/shellcheck/releases/download/{}/shellcheck-{}.zip
  mkdir /usr/local/src/shellcheck
  unzip -d /usr/local/src/shellcheck /tmp/shellcheck.zip
  rm -f /tmp/shellcheck.zip
fi

if [[ ! -d '/usr/local/src/shunit2' ]]; then
  print-github-tags --latest --release --tar kward/shunit2 \
    | xargs curl -SL -o /tmp/shunit2.tar.gz
  tar xvf /tmp/shunit2.tar.gz -C /usr/local/src
  mv /usr/local/src/shunit2-* /usr/local/src/shunit2
  rm -f /tmp/shunit2.tar.gz
fi

if [[ ! -d '/usr/local/src/rain' ]]; then
  print-github-tags --latest --release aws-cloudformation/rain \
    | xargs -I{} curl -SL -o /tmp/rain.zip \
      https://github.com/aws-cloudformation/rain/releases/download/{}/rain-{}_windows-amd64.zip
  unzip -d /usr/local/src /tmp/rain.zip
  mv /usr/local/src/rain-* /usr/local/src/rain
  rm -f /tmp/rain.zip
fi

cd /usr/local/bin
find \
  ../src/git-rewind-days ../src/print-github-tags ../src/shellcheck \
  ../src/shunit2 ../src/rain -type f -executable -exec ln -sf {} . \;
cd "${WD}"

curl -SL -o ~/.zshrc \
  https://raw.githubusercontent.com/dceoy/ansible-dev/master/roles/cli/files/zshrc
curl -SL -o ~/.vimrc \
  https://raw.githubusercontent.com/dceoy/ansible-dev/master/roles/vim/files/vimrc
curl -SL -o /tmp/install_latest_vim.sh \
  https://raw.githubusercontent.com/dceoy/install-latest-vim/master/install_latest_vim.sh
bash /tmp/install_latest_vim.sh --debug --lua --dein
rm -f /tmp/install_latest_vim.sh

if python -m pip --version; then
  python -m pip install -U --no-cache-dir pip pyproject.toml
else
  curl -SL -o /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py
  python /tmp/get-pip.py install -U --no-cache-dir pip pyproject.toml
  rm -f /tmp/get-pip.py
fi
python -m pip install -U --no-cache-dir \
  ansible ansible-lint autopep8 aws-parallelcluster bash_kernel boto3 csvkit \
  cfn-lint docopt flake8 flake8-bugbear flake8-isort ggplot \
  git-remote-codecommit grip jupyterlab jupyterthemes luigi pep8-naming plotly \
  polars pynvim sklearn-pandas tqdm vim-vint vulture yamllint yq

gem install sqlint statelint || :

# npm -g config set proxy "${HTTP_PROXY}"
npm -g install ajv-cli eslint eslint-config-airbnb eslint-plugin-import \
  jsonlint npx  typescript yarn || :
