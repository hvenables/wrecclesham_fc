class CreateCups < ActiveRecord::Migration[5.0]
  def change
    create_table :cups do |t|
      t.integer :year
      t.string :name
      t.string :abbreviation

      t.timestamps
    end
  end
end
