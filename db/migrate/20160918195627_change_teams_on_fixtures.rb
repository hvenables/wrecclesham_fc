class ChangeTeamsOnFixtures < ActiveRecord::Migration[5.0]
  def change
    change_column :fixtures, :home, "integer USING CAST(home AS integer)"
    change_column :fixtures, :away, "integer USING CAST(away AS integer)"
  end
end
