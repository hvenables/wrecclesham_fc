class AddLeagueTableIdToFixtures < ActiveRecord::Migration[5.0]
  def change
    add_reference :fixtures, :league_table, foreign_key: true
  end
end
