class AddAvatarColumnsToImages < ActiveRecord::Migration[5.1]
  def up
    add_attachment :images, :image
  end

  def down
    remove_attachment :images, :image
  end
end
