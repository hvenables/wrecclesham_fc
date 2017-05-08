# frozen_string_literal: true

class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.text :summary
      t.string :url

      t.timestamps
    end
  end
end
