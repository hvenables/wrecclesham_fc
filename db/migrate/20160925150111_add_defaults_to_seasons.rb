# frozen_string_literal: true

class AddDefaultsToSeasons < ActiveRecord::Migration[5.0]
  def change
    change_column :seasons, :games, :integer, default: 0
    change_column :seasons, :won, :integer, default: 0
    change_column :seasons, :drawn, :integer, default: 0
    change_column :seasons, :lost, :integer, default: 0
    change_column :seasons, :goals_for, :integer, default: 0
    change_column :seasons, :goals_against, :integer, default: 0
    change_column :seasons, :goals_difference, :integer, default: 0
    change_column :seasons, :points, :integer, default: 0
    change_column :seasons, :home_wins, :integer, default: 0
    change_column :seasons, :home_drawn, :integer, default: 0
    change_column :seasons, :home_lost, :integer, default: 0
    change_column :seasons, :home_goals_for, :integer, default: 0
    change_column :seasons, :home_goals_against, :integer, default: 0
    change_column :seasons, :away_wins, :integer, default: 0
    change_column :seasons, :away_drawn, :integer, default: 0
    change_column :seasons, :away_lost, :integer, default: 0
    change_column :seasons, :away_goals_for, :integer, default: 0
    change_column :seasons, :away_goals_against, :integer, default: 0
  end
end
