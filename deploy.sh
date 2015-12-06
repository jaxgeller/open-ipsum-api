#!/bin/bash
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install postgresql postgresql-contrib libpq-dev libgmp3-dev git curl nginx -y

echo "gem: --no-ri --no-rdoc" >> "$HOME"/.gemrc

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

\curl -sSL https://get.rvm.io | bash -s stable --ruby=2.2.3

source /home/ubuntu/.rvm/scripts/rvm

gem install bundler

mkdir -p {openipsum-api.git,openipsum-api}

cd openipsum-api.git && git init --bare

echo -e "
#!/bin/sh
git --work-tree="$HOME"/openipsum-api --git-dir="$HOME"/openipsum-api.git checkout -f
" >> hooks/post-receive

chmod +x hooks/post-receive

# set up postgres
sudo -u postgres createuser -s openipsum-api
sudo -u postgres psql
# \password openipsum-api

mkdir -p shared/pids shared/sockets shared/log

