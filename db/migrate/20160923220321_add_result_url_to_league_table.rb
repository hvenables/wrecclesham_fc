class AddResultUrlToLeagueTable < ActiveRecord::Migration[5.0]
  def change
    add_column :league_tables, :results_url, :string
  end
end
