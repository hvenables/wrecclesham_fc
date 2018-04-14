# frozen_string_literal: true

class AddAssociationToImage < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :subject_id, :integer
    add_column :images, :subject_type, :string
  end
end
