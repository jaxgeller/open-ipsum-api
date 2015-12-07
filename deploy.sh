#!/bin/bash
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install postgresql postgresql-contrib libpq-dev libgmp3-dev git curl nginx -y

echo "gem: --no-ri --no-rdoc" >> "$HOME"/.gemrc && \
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
\curl -sSL https://get.rvm.io | bash -s stable --ruby=2.2.3 && \
source /home/ubuntu/.rvm/scripts/rvm && \
gem install bundler

mkdir -p {openipsum-api.git,openipsum-api}
cd openipsum-api.git && git init --bare
echo -e "
#!/bin/sh
git --work-tree="$HOME"/openipsum-api --git-dir="$HOME"/openipsum-api.git checkout -f
" >> hooks/post-receive
chmod +x hooks/post-receive

sudo -u postgres createuser -s ubuntu
sudo -u postgres psql
# \password openipsum-api

rake db:create
rake db:reset
rake secret

mkdir -p production/{pids,sockets,log}


cd ~
wget https://raw.githubusercontent.com/puma/puma/master/tools/jungle/upstart/puma-manager.conf
wget https://raw.githubusercontent.com/puma/puma/master/tools/jungle/upstart/puma.conf

vi puma.conf
# setuid ubuntu
# setgid ubuntu

sudo cp puma.conf puma-manager.conf /etc/init

sudo vi /etc/puma.conf
/home/ubuntu/open-ipsum-api

sudo start puma-manager


sudo vi /etc/nginx/sites-available/default
# upstream app {
#     server unix:/home/ubuntu/open-ipsum-api/production/sockets/puma.sock fail_timeout=0;
# }
# server {
#     listen 80;
#     server_name localhost;

#     root /home/deploy/appname/public;

#     try_files $uri/index.html $uri @app;

#     location @app {
#         proxy_pass http://app;
#         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#         proxy_set_header Host $http_host;
#         proxy_redirect off;
#     }

#     error_page 500 502 503 504 /500.html;
#     client_max_body_size 4G;
#     keepalive_timeout 10;
# }


sudo service nginx restart

# sudo passenger-config validate-install
