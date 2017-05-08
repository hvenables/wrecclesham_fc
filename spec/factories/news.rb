# frozen_string_literal: true

FactoryGirl.define do
  factory :news, class: News do
    title 'Title'
    content 'Content'
    image { File.new("#{Rails.root}/spec/support/fixtures/image.png") }
  end
end
