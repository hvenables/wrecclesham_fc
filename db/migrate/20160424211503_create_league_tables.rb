class CreateLeagueTables < ActiveRecord::Migration[5.0]
  def change
    create_table :league_tables do |t|
      t.integer :year
      t.string :name
      t.integer :promoted
      t.integer :relegated

      t.timestamps
    end
  end
end
