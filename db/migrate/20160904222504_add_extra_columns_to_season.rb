class AddExtraColumnsToSeason < ActiveRecord::Migration[5.0]
  def change
    add_column :seasons, :home_wins, :integer
    add_column :seasons, :home_drawn, :integer
    add_column :seasons, :home_lost, :integer
    add_column :seasons, :home_goals_for, :integer
    add_column :seasons, :home_goals_against, :integer
    add_column :seasons, :away_wins, :integer
    add_column :seasons, :away_drawn, :integer
    add_column :seasons, :away_lost, :integer
    add_column :seasons, :away_goals_for, :integer
    add_column :seasons, :away_goals_against, :integer
  end
end
