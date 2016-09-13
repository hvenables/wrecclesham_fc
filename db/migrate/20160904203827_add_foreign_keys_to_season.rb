class AddForeignKeysToSeason < ActiveRecord::Migration[5.0]
  def change
    add_column :seasons, :league_table_id, :integer
    add_column :seasons, :team_id, :integer
    add_foreign_key :seasons, :league_tables
    add_foreign_key :seasons, :teams
  end
end
