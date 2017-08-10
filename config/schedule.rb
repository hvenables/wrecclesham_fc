# frozen_string_literal: true

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

every :day, at: '2am' do
  rake 'update_league_tables'
end
every :day, at: '3am' do
  rake 'get_results'
end
every :day, at: '4am' do
  rake 'get_fixtures'
end

# every '30 2 * * 4' do
#   rake 'delete_cancelled'
# end
