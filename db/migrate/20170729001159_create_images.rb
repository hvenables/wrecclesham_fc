class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :title
    end

    execute('ALTER SEQUENCE images_id_seq RESTART 20')
  end
end
