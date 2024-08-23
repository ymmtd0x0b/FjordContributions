# frozen_string_literal: true

FactoryBot.define do
  factory :issue do
    sequence(:title) { |n| "issue#{n}" }
    sequence(:number)

    trait :with_author do
      association :author, factory: :user
    end

    trait :with_repository do
      association :repository
    end
  end
end
