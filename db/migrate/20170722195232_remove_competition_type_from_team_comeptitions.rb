# frozen_string_literal: true

class RemoveCompetitionTypeFromTeamComeptitions < ActiveRecord::Migration[5.0]
  def change
    remove_column :team_competitions, :competition_type
  end
end
