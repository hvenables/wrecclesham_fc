class AddUrlsToCup < ActiveRecord::Migration[5.0]
  def change
    add_column :cups, :fixture_url, :string
    add_column :cups, :result_url, :string
  end
end
