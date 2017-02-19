class RemoveForeignKeyFromFixtures < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :fixtures, column: :competition_id
  end
end
