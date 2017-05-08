# frozen_string_literal: true

class AddLeagueTableToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :league_table_id, :integer
    add_foreign_key :teams, :league_tables
  end
end
