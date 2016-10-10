class ChangeScoreFieldToText < ActiveRecord::Migration[5.0]
  def change
    change_column :fixtures, :home_score, :string
    change_column :fixtures, :away_score, :string
  end
end
