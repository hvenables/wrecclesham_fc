class ChangeIntegerToStringFixtures < ActiveRecord::Migration[5.0]
  def change
    change_column :fixtures, :home_score, :string
  end
end
