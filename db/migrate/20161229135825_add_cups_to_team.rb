class AddCupsToTeam < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :cups, :text
  end
end
