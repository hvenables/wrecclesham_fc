class ChangeLeagueToTeams < ActiveRecord::Migration[5.0]
  def change
    rename_table :league_tables, :teams
  end
end
