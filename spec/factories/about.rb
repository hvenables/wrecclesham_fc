# frozen_string_literal: true

FactoryBot.define do
  factory :about, class: About do
    content { 'Test About' }
  end
end
