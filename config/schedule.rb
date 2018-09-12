# frozen_string_literal: true

every :day, at: '2am' do
  runner 'LeagueTableUpdateJob.perform_now'
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
