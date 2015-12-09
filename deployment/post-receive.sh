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
