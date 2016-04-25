class AddLeagueTableIdToTeams < ActiveRecord::Migration[5.0]
  def change
    add_reference :teams, :league_table, foreign_key: true
  end
end
