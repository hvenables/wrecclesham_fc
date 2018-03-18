# frozen_string_literal: true

FactoryBot.define do
  factory :image, class: Image do
    image { File.new("#{Rails.root}/spec/support/fixtures/image.png") }
  end
end
