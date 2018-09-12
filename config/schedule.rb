# frozen_string_literal: true

every :day, at: '2am' do
  runner 'LeagueTableUpdateJob.perform_now'
end

every :day, at: '3am' do
  runner 'FixtureUpdateJob.perform_now'
end

every :day, at: '4am' do
  runner 'ResultUpdateJob.perform_now'
end
