# frozen_string_literal: true

class AddAttachmentImageToNews < ActiveRecord::Migration[5.0]
  def self.up
    change_table :news do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :news, :image
  end
end
