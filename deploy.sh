#!/bin/bash
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install postgresql postgresql-contrib libpq-dev libgmp3-dev git curl nginx build-essential -y

echo "gem: --no-ri --no-rdoc" >> "$HOME"/.gemrc && \
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
\curl -sSL https://get.rvm.io | bash -s stable --ruby=2.2.3 && \
source /home/ubuntu/.rvm/scripts/rvm && \
gem install bundler

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
nvm install v4.2.2
npm install ember-cli bower -g

sudo -u postgres createuser -s ubuntu
sudo -u postgres psql
# \password openipsum-api

rake db:create
rake db:reset
rake secret


# mkdir -p {openipsum-api.git,openipsum-api}
# cd openipsum-api.git && git init --bare
# echo -e "
# #!/bin/sh
# git --work-tree="$HOME"/openipsum-api --git-dir="$HOME"/openipsum-api.git checkout -f
# " >> hooks/post-receive
# chmod +x hooks/post-receive


# server {
#   server_name api.openipsum.com;
#   listen 80;
#   access_log /home/ubuntu/logs/access.log;
#         error_log /home/ubuntu/logs/error.log;

#   location / {
#     proxy_pass http://127.0.0.1:3000;
#   }
# }
# server {
#   server_name openipsum.com;
#   root /home/ubuntu/open-ipsum-ui/dist;
#   index index.html index.htm;
#   location / {
#           try_files $uri $uri/ /index.html?/$request_uri;
#       }
# }
