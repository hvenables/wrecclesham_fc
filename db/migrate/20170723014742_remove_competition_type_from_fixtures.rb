# frozen_string_literal: true

class RemoveCompetitionTypeFromFixtures < ActiveRecord::Migration[5.0]
  def change
    remove_column :fixtures, :competition_type
  end
end
