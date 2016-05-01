module FixturesHelper
  def create_fixtures(fixtures, dates, current_league)
    fixtures.each_with_index do |month, month_index|
      month.each_with_index do |week, week_index|
        week.each do |fixture|
          Fixture.create!(
            date: dates[month_index][week_index][0],
            home: fixture[2],
            away: fixture[4],
            home_score: fixture[0],
            away_score: fixture[1],
            league_table_id: current_league
          )
        end
      end
    end
  end
end
