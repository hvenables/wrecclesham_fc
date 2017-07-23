class DropLeagueTableAndCup < ActiveRecord::Migration[5.0]
  def change
    drop_table :cups
    drop_table :league_tables
  end
end
