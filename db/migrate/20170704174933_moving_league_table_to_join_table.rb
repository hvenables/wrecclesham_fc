# frozen_string_literal: true

class MovingLeagueTableToJoinTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :teams, :league_table_id
  end
end
