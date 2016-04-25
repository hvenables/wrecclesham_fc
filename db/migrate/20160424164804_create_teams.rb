class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :team
      t.integer :games
      t.integer :won
      t.integer :drawn
      t.integer :lost
      t.integer :goals_for
      t.integer :goals_against
      t.integer :goal_difference
      t.integer :points

      t.timestamps
    end
  end
end
