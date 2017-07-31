class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :title
    end

    execute("ALTER TABLE tbl AUTO_INCREMENT = 20")
  end
end
