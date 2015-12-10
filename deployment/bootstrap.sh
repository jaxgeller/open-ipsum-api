#!/bin/bash
#
# Meant to be deployed on Ubuntu 14.04 LTS

# Upgrade Posgresql to 9.4
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Update all dependencies
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install postgresql postgresql-contrib libpq-dev libgmp3-dev git curl nginx build-essential -y

# Get and set ENV Variables
echo -n "DATABASE_PASSWORD="; read DATABASE_PASSWORD
echo -n "USER_PASSWORD="; read USER_PASSWORD

# Set up Postgres
sudo -u postgres createuser -s ubuntu
sudo -u postgres psql -c "ALTER USER ubuntu WITH PASSWORD '$DATABASE_PASSWORD';"

# Init bashrc
echo -e "
export RAILS_ENV=production
export OPENIPSUM_DATABASE_USERNAME=ubuntu
export OPENIPSUM_DATABASE_PASSWORD=$DATABASE_PASSWORD
export OPENIPSUM_USER_PASS=$USER_PASS
" >> "$HOME/.bashrc"

# Install Ruby 2.2.3
echo "gem: --no-ri --no-rdoc" >> "$HOME"/.gemrc
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby=2.2.3
source "$HOME/.rvm/scripts/rvm"
gem install bundler

# Install Node 4.2.2
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
source "$HOME/.bashrc"
source "$HOME/.nvm/nvm.sh"
nvm install v4.2.2
nvm alias default v4.2.2
npm install ember-cli bower -g

# Init HOME Directory
mkdir -p /home/ubuntu/{api,certs,git-deploys/{api.git,ui.git},ui,logs}

# Install and init API source, set keybase
cd "$HOME/api"
git clone https://github.com/jaxgeller/open-ipsum-api .
bundle install
SECRET_KEY_BASE=$(rake secret)
echo "export SECRET_KEY_BASE=$SECRET_KEY_BASE" >> "$HOME/.bashrc"
source "$HOME/.bashrc"
RAILS_ENV=production rake db:create
RAILS_ENV=production rake db:reset
bundle exec puma --daemon

# Install and init UI Source
cd "$HOME/ui"
git clone https://github.com/jaxgeller/open-ipsum-ui .
npm install && bower install
ember build -prod

# Setup git hooks
cd "$HOME/git-deploys/api.git" && git init --bare
echo "
#!/bin/bash
WORK_TREE=/home/ubuntu/api
GIT_TREE=/home/ubuntu/git-deploys/api.git
git --work-tree=\$WORK_TREE --git-dir=\$GIT_TREE checkout -f
cd \$WORK_TREE
/home/ubuntu/.rvm/bin/rvm 2.2.3 do bundle install
RAILS_ENV=production /home/ubuntu/.rvm/bin/rvm 2.2.3 do rake db:migrate
RAILS_ENV=production /home/ubuntu/.rvm/bin/rvm 2.2.3 do rake db:seed
kill -9 \$(cat /tmp/puma.pid)
RAILS_ENV=production /home/ubuntu/.rvm/bin/rvm 2.2.3 do bundle exec puma --daemon
" > hooks/post-receive
chmod +x hooks/post-receive

cd "$HOME/git-deploys/ui.git" && git init --bare
echo "
#!/bin/bash
WORK_TREE=/home/ubuntu/ui
GIT_TREE=/home/ubuntu/git-deploys/ui.git
export PATH=/home/ubuntu/.nvm/versions/node/v4.2.2/bin:\$PATH
git --work-tree=\$WORK_TREE --git-dir=\$GIT_TREE checkout -f
cd \$WORK_TREE
/home/ubuntu/.nvm/versions/node/v4.2.2/bin/npm install
/home/ubuntu/.nvm/versions/node/v4.2.2/bin/bower install
/home/ubuntu/.nvm/versions/node/v4.2.2/bin/ember build -prod
" > hooks/post-receive
chmod +x hooks/post-receive

# Add Server Startup Script
sudo bash -c 'echo "
start on filesystem and started networking
chdir /home/ubuntu/api
env RAILS_ENV=production
exec /home/ubuntu/.rvm/bin/rvm 2.2.3 do bundle exec puma --daemon
" > /etc/init/openipsum-api.conf'

# Add nginx scripts
sudo bash -c 'echo "
upstream api {
  server unix:/tmp/puma.sock;
}
server {
  listen 80;
  server_name api.openipsum.com;
  rewrite ^/(.*) https://api.openipsum.com/\$1 permanent;
}
server {
  listen 443 ssl;
  server_name api.openipsum.com;
  location / {
    proxy_pass http://api;
  }
  ssl_certificate         /home/ubuntu/certs/openipsum_com.chained.crt;
  ssl_certificate_key     /home/ubuntu/certs/openipsum.com.key;
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_prefer_server_ciphers on;
  ssl_ciphers AES256+EECDH:AES256+EDH:!aNULL;
}
" > /etc/nginx/sites-enabled/api.conf'

sudo bash -c 'echo "
server {
  listen 80;
  server_name openipsum.com;
  rewrite ^/(.*) https://openipsum.com/\$1 permanent;
}
server {
  listen 443 ssl;
  server_name openipsum.com;
  root /home/ubuntu/ui/dist;
  index index.html index.htm;
  location / {
    try_files \$uri \$uri/ /index.html?/\$request_uri;
  }
  ssl_certificate   /home/ubuntu/certs/openipsum_com.chained.crt;
  ssl_certificate_key   /home/ubuntu/certs/openipsum.com.key;
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_prefer_server_ciphers on;
  ssl_ciphers AES256+EECDH:AES256+EDH:!aNULL;
}
" > /etc/nginx/sites-enabled/ui.conf'

sudo sed -i 's/# gzip_vary on;/gzip_vary on;/g' /etc/nginx/nginx.conf
sudo sed -i 's/# gzip_proxied any;/gzip_proxied any;/g' /etc/nginx/nginx.conf
sudo sed -i 's/# gzip_types /gzip_types /g' /etc/nginx/nginx.conf

# Add server startup script

echo "remember to add SSL certs! And to restart!"
