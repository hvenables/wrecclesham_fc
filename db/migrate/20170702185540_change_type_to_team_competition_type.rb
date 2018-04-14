# frozen_string_literal: true

class ChangeTypeToTeamCompetitionType < ActiveRecord::Migration[5.0]
  def change
    rename_column :team_competitions, :type, :competition_type
  end
end
