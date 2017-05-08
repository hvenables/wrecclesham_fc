# frozen_string_literal: true

class AddActiveToCups < ActiveRecord::Migration[5.0]
  def change
    add_column :cups, :active, :boolean, default: :true
  end
end
