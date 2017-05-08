# frozen_string_literal: true

class CreateSeasons < ActiveRecord::Migration[5.0]
  def change
    create_table :seasons do |t|
      t.integer :games
      t.integer :won
      t.integer :drawn
      t.integer :lost
      t.integer :goals_for
      t.integer :goals_against
      t.integer :goals_difference
      t.integer :points

      t.timestamps
    end
  end
end
