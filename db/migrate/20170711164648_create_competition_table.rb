# frozen_string_literal: true

class CreateCompetitionTable < ActiveRecord::Migration[5.0]
  def change
    create_table :competitions do |t|
      t.string :type
      t.integer :year
      t.string :name
      t.string :abbreviation
      t.string :url
      t.string :fixture_url
      t.string :result_url
      t.boolean :active

      t.timestamps
    end
  end
end

