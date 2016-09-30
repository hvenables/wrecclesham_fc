class UpdateTeams
  def self.update
    Team.all.each do |team|
      league_table = team.seasons.first.league_table
      team.update(league_table: league_table)
    end
  end
end
