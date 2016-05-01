class AddUrlToFixtures < ActiveRecord::Migration[5.0]
  def change
    add_column :league_tables, :fixture_url, :string
  end
end
