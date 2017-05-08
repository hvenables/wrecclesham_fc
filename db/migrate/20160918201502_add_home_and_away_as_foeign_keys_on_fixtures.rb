# frozen_string_literal: true

class AddHomeAndAwayAsFoeignKeysOnFixtures < ActiveRecord::Migration[5.0]
  def change
    rename_column :fixtures, :home, :home_id
    rename_column :fixtures, :away, :away_id
    add_foreign_key :fixtures, :teams, column: 'home_id'
    add_foreign_key :fixtures, :teams, column: 'away_id'
  end
end
