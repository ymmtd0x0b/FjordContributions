# frozen_string_literal: true

FactoryBot.define do
  factory :pull_request do
    sequence(:number)

    trait :with_repository do
      association :repository
    end
  end
end
