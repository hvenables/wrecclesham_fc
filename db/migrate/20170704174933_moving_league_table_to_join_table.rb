# frozen_string_literal: true

class MovingLeagueTableToJoinTable < ActiveRecord::Migration[5.0]
  def change
    LeagueTable.all.each do |league_table|
      league_table.teams << Team.where(league_table_id: league_table.id)
      league_table.save
    end

    remove_column :teams, :league_table_id
  end
end
