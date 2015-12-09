#!/bin/bash

# Meant to be deployed on Ubuntu 14.04 LTS

# Upgrade Posgresql to 9.4
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Update all dependencies
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install postgresql postgresql-contrib libpq-dev libgmp3-dev git curl nginx build-essential -y

# Get and set ENV Variables
echo "DATABASE_PASSWORD="; read DATABASE_PASSWORD

# Set up Postgres
sudo -u postgres createuser -s ubuntu
sudo -u postgres psql -c "ALTER USER ubuntu WITH PASSWORD '$DATABASE_PASSWORD';"

# Init bashrc
echo -e "
export RAILS_ENV=production
export OPENIPSUM_DATABASE_USERNAME=ubuntu
export OPENIPSUM_DATABASE_PASSWORD=$DATABASE_PASSWORD
" >> "$HOME/.bashrc"

# Install Ruby 2.2.3
echo "gem: --no-ri --no-rdoc" >> "$HOME"/.gemrc
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby=2.2.3
source /home/ubuntu/.rvm/scripts/rvm
gem install bundler

# Install and init source, set keybase
git clone https://github.com/jaxgeller/open-ipsum-api api
cd api
bundle install
SECRET_KEY_BASE=$(rake secret)
echo "export SECRET_KEY_BASE=$SECRET_KEY_BASE" >> "$HOME/.bashrc"
source "$HOME/.bashrc"
rake db:create
rake db:reset

# Setup git hooks
mkdir -p "$HOME/git-deploys/api.git"
cd "$HOME/git-deploys/api.git" && git init --bare
echo "
#!/bin/bash
WORK_TREE=/home/ubuntu/api
GIT_TREE=/home/ubuntu/git-deploys/api.git
git --work-tree=$WORK_TREE --git-dir=$GIT_TREE checkout -f
cd $WORK_TREE
/home/ubuntu/.rvm/bin/rvm 2.2.3 do bundle install
/home/ubuntu/.rvm/bin/rvm 2.2.3 do rake db:migrate
kill -9 $(cat /tmp/puma.pid)
/home/ubuntu/.rvm/bin/rvm 2.2.3 do bundle exec puma
sudo service nginx restart
" >> hooks/post-receive
chmod +x hooks/post-receive

mkdir -p "$HOME/git-deploys/ui.git"
cd "$HOME/git-deploys/ui.git" && git init --bare
