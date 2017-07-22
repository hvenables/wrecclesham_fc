class AddForeignKeysToTeamCompetitions < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :team_competitions, :teams
  end
end
