# frozen_string_literal: true

class AddPositionToSeasons < ActiveRecord::Migration[5.0]
  def change
    add_column :seasons, :position, :integer
  end
end
