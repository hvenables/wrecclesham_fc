# frozen_string_literal: true

class AddActiveLeagueToLeagueTables < ActiveRecord::Migration[5.0]
  def change
    add_column :league_tables, :active_first_team_table, :boolean, default: false, null: false
    add_column :league_tables, :active_reserve_team_table, :boolean, default: false, null: false
  end
end
