class CreateFixtures < ActiveRecord::Migration[5.0]
  def change
    create_table :fixtures do |t|
      t.date :date
      t.string :home
      t.string :away
      t.integer :home_score
      t.string :away_score_integer

      t.timestamps
    end
  end
end
