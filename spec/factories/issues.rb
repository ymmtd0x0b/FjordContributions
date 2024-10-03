# frozen_string_literal: true

FactoryBot.define do
  factory :issue do
    sequence(:title) { |n| "issue#{n}" }
    sequence(:number)
    association :author, strategy: :build_stubbed # 自作サービスの仕様上、Issue 登録時に作成者のユーザーがデータベース上に存在するとは限らない

    trait :with_author do
      association :author
    end

    trait :with_repository do
      association :repository
    end
  end
end
