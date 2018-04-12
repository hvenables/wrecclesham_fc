class RemoveTitleFromAbout < ActiveRecord::Migration[5.1]
  def change
    remove_column :abouts, :title
  end
end
