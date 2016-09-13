module SeasonsHelper
  def create_teams(table, current_league)
    table.each do |season|
      Season.create!(
        position: season[0],
        team: Team.find_or_create_by!(name: season[1].underscore.split('_').collect{|c| c.capitalize}.join(' ')),
        games: season[2],
        won: season[13],
        drawn: season[14],
        lost: season[15],
        goals_for: season[16],
        goals_against: season[17],
        goals_difference: season[16].to_i - season[17].to_i,
        points: season[19],
        league_table_id: current_league,
        home_wins: season[3],
        home_drawn: season[4],
        home_lost: season[5],
        home_goals_for: season[6],
        home_goals_against: season[7],
        away_wins: season[8],
        away_drawn: season[9],
        away_lost: season[10],
        away_goals_for: season[11],
        away_goals_against: season[12]
      )
    end
  end

  def update_teams(table, current_league)
    table.each do |season|
      current_team = Team.find_by(name: season[1].underscore.split('_').collect{|c| c.capitalize}.join(' '))
      current_season = Season.find_by(team: current_team, league_table: current_league)
      current_season.update!(
        position: season[0],
        team: current_team,
        games: season[2],
        won: season[13],
        drawn: season[14],
        lost: season[15],
        goals_for: season[16],
        goals_against: season[17],
        goals_difference: season[16].to_i - season[17].to_i,
        points: season[19],
        league_table_id: current_league,
        home_wins: season[3],
        home_drawn: season[4],
        home_lost: season[5],
        home_goals_for: season[6],
        home_goals_against: season[7],
        away_wins: season[8],
        away_drawn: season[9],
        away_lost: season[10],
        away_goals_for: season[11],
        away_goals_against: season[12],
      )
    end
  end
end
