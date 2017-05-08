# frozen_string_literal: true

class ChangeFixtureLeagueTableIdToPolymorphic < ActiveRecord::Migration[5.0]
  def change
    rename_column :fixtures, :league_table_id, :competition_id
    add_column :fixtures, :competition_type, :string

    reversible do |dir|
      dir.up { execute("UPDATE fixtures SET competition_type = 'LeagueTable'") }
    end
  end
end
