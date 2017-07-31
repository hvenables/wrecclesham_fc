# frozen_string_literal: true

FactoryGirl.define do
  factory :news, class: News do
    title 'Title'
    content 'Content'
    after(:build) do |news|
      news.images << FactoryGirl.create(:image)
    end
  end
end
