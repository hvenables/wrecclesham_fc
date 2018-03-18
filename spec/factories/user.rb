# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
    email 'test@test.com'
    password 'password'

    factory :admin do
      admin true
    end
  end
end
