# frozen_string_literal: true

FactoryBot.define do
  factory :wiki do
    sequence(:title) { |n| "Wiki#{n}" }
    sequence(:first_commit_hash) { |n| Digest::SHA1.hexdigest(n.to_s) }

    trait :with_repository do
      association :repository
    end

    trait :with_author do
      association :author
    end
  end
end
