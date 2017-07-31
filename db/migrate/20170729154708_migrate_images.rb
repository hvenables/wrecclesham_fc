# frozen_string_literal: true

class MigrateImages < ActiveRecord::Migration[5.1]
  def change
    News.all.each do |news|
      Image.create(
        id: news.id,
        image_file_name: news.image_file_name,
        image_content_type: news.image_content_type,
        image_file_size: news.image_file_size,
        image_updated_at: news.image_updated_at,
        subject_id: news.id,
        subject_type: 'News'
      )
    end
  end
end
