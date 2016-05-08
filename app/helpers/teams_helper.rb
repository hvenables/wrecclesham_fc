module TeamsHelper
  def create_teams(table, current_league)
    table.each do |team|
      Team.create!(
        team: team[0],
        games: team[1],
        won: team[2],
        drawn: team[3],
        lost: team[4],
        goals_for: team[5],
        goals_against: team[6],
        goal_difference: team[5].to_i - team[6].to_i,
        points: team[8],
        league_table_id: current_league
      )
    end
  end

  def update_teams(table, current_league)
    table.each do |team|
      current_team = Team.where("team = ? AND league_table_id = ?", team[0], current_league).first
      current_team.update!(
        team: team[0],
        games: team[1],
        won: team[2],
        drawn: team[3],
        lost: team[4],
        goals_for: team[5],
        goals_against: team[6],
        goal_difference: team[5].to_i - team[6].to_i,
        points: team[8],
        league_table_id: current_league
      )
    end
  end
end
