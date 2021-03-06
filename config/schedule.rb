# coding: utf-8
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# 出力先のログファイルの指定
set :output, {:error => 'log/error.log', :standard => 'log/cron.log'}
# ジョブの実行環境の指定
set :environment, :production

=begin
every 1.minutes do
  runner "Article.bulk_analize!"
end

every 1.minutes do
  runner "AsahiArticle.crawl"
end

every 1.minutes do
  command "cd /Users/taku/workspace/workspace_ruby/mocal && mysqldump -u root -t mocals_development mst_companies articles company_source_relations crawl_logs sentences > dump.sql && git add dump.sql && git commit -m 'auto sql commit'"
end
=end