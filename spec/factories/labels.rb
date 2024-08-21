# frozen_string_literal: true

FactoryBot.define do
  factory :label do
    name { 'bug' }
    color { 'FF0000' }

    trait :with_repository do
      association :repository
    end
  end
end
