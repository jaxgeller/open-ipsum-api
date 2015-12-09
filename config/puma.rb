rails_env = ENV['RAILS_ENV'] || 'production'
environment rails_env

app_dir = File.expand_path("../..", __FILE__)

workers 2
threads 1, 6

bind 'unix:/tmp/puma.sock'
pidfile '/tmp/puma.pid'

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
end
