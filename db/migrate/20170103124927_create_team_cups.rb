class CreateTeamCups < ActiveRecord::Migration[5.0]
  def change
    create_table :team_cups do |t|
      t.belongs_to :team, index: true
      t.belongs_to :cup, index: true
      t.boolean :active

      t.timestamps
    end
  end
end
