# frozen_string_literal: true

class AddAbbreviationToLeagueTables < ActiveRecord::Migration[5.0]
  def change
    add_column :league_tables, :abbreviation, :string, after: :name
  end
end
