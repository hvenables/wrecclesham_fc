# frozen_string_literal: true

class AddDefaultToCompetitionActivity < ActiveRecord::Migration[5.1]
  def change
    change_column :competitions, :active, :boolean, default: false
  end
end
