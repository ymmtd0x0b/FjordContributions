# frozen_string_literal: true

FactoryBot.define do
  factory :label do
    sequence :name, %i[bug fix 新機能 1 2 3 5].cycle
    color { 'FF0000' }

    trait :with_repository do
      association :repository
    end
  end
end
