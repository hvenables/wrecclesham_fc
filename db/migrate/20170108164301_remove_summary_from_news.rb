# frozen_string_literal: true

class RemoveSummaryFromNews < ActiveRecord::Migration[5.0]
  def change
    remove_column :news, :summary
  end
end
