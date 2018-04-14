# frozen_string_literal: true

class RemoveLeagueTableForeignKey < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :seasons, :league_tables
  end
end
