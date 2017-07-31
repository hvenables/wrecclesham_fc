# frozen_string_literal: true

class Image < ApplicationRecord
  belongs_to :subject, polymorphic: true, inverse_of: :images

  has_attached_file :image,
                    styles: { large: '600x600>', medium: '320x250>', thumb: '100x100>' },
                    default_url: '/images/:style/missing.png',
                    s3_protocol: :https
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
