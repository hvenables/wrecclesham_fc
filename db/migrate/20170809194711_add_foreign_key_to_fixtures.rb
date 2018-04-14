# frozen_string_literal: true

class AddForeignKeyToFixtures < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :fixtures, :competitions
  end
end
