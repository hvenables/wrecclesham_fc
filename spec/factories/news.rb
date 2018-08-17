# frozen_string_literal: true

FactoryBot.define do
  factory :news, class: News do
    title { 'Title' }
    content { 'Content' }
    after(:build) do |news|
      news.images << FactoryBot.create(:image)
    end
  end
end
