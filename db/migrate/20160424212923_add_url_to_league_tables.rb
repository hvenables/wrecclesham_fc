class AddUrlToLeagueTables < ActiveRecord::Migration[5.0]
  def up
    add_column :league_tables, :url, :string
  end
end
