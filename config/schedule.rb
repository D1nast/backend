# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#

require File.expand_path(File.dirname(__FILE__) + '/environment')

# /backend/config/environmentのディレクトリ
# rails_env = :development
# set :environment, rails_env
# set :output, "#{Rails.root}/log/cron.log"
# job_type :rake, "source ~/.zshrc; export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"

# 本番環境ならこっち
set :environment, 'production'
set :output, "#{Rails.root}/log/cron.log"
job_type :rake, "source ~/.zshrc; export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && bundle exec rake :task RAILS_ENV=:environment :output"

# 本番環境:productionでもやりたい 
every 1.day, at: '7:00 am' do
  rake 'send_mail:mail'
end



# crontabは本番環境でも動いてくれるけど、メール送信ができない
# 

# Learn more: http://github.com/javan/whenever
