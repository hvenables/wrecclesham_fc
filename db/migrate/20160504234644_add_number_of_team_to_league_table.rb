class AddNumberOfTeamToLeagueTable < ActiveRecord::Migration[5.0]
  def change
    add_column :league_tables, :number_of_teams, :integer
  end
end
