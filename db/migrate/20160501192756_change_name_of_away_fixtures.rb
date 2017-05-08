# frozen_string_literal: true

class ChangeNameOfAwayFixtures < ActiveRecord::Migration[5.0]
  def change
    rename_column :fixtures, :away_score_integer, :away_score
  end
end
