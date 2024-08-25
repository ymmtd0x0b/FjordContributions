# frozen_string_literal: true

FactoryBot.define do
  factory :wiki do
    sequence(:title) { |n| "Wiki#{n}" }
    first_commit_hash { Digest::SHA1.hexdigest(rand(100).to_s) }

    trait :with_repository do
      association :repository
    end

    trait :with_author do
      association :author
    end
  end
end
