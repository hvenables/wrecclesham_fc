class ChangeTeamCupsToTeamCompetitions < ActiveRecord::Migration[5.0]
  def change
    remove_column :team_cups, :active
    rename_column :team_cups, :cup_id, :competition_id
    add_column :team_cups, :type, :string, after: :competition_id
    rename_table :team_cups, :team_competitions
  end
end
