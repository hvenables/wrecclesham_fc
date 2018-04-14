# frozen_string_literal: true

class AddDefaultsToSeasons < ActiveRecord::Migration[5.0]
  def change
    %i[
      games won drawn lost goals_for goals_against goals_difference points
      home_wins home_drawn home_lost home_goals_for home_goals_against away_wins
      away_drawn away_lost away_goals_for away_goals_against
    ].each do |table_column|
      change_column :seasons, table_column, :integer, default: 0
    end
  end
end
