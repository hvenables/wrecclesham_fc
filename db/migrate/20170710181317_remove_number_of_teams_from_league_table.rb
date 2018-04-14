# frozen_string_literal: true

class RemoveNumberOfTeamsFromLeagueTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :league_tables, :number_of_teams
  end
end
