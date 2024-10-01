# frozen_string_literal: true

class Issue < ApplicationRecord
  belongs_to :author, class_name: 'User', optional: true # 親データは存在しなくても良いが、 optional: true は null を許容してしまうので以下にバリデーションを追加
  validates :author_id, presence: true

  belongs_to :repository

  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings, source: :label

  has_many :assigns, as: :assignable, dependent: :destroy
  has_many :assignees, through: :assigns, source: :user

  has_many :resolutions, dependent: :destroy
  has_many :pull_requests, through: :resolutions, source: :pull_request

  class << self
    def synchronize(issues_by_github_api)
      hash_list = issues_by_github_api.map(&:to_h)
      upsert_all(hash_list) if hash_list.any?

      Labeling.synchronize(issues_by_github_api)
    end
  end
end
