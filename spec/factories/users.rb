# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "tester#{n}" }
    avatar_url { 'https://example.com/avatar.png' }
  end
end
