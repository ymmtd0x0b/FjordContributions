# frozen_string_literal: true

class PullRequest < ApplicationRecord
  belongs_to :repository

  has_many :assigns, as: :assignable, dependent: :destroy
  has_many :assignees, through: :assigns, source: :user

  has_many :reviews, dependent: :destroy
  has_many :reviewers, through: :reviews, source: :user

  has_many :resolutions, dependent: :destroy
  has_many :issues, through: :resolutions, source: :issue

  class << self
    def synchronize(pull_requests_by_github_api)
      hash_list = pull_requests_by_github_api.map(&:to_h)
      upsert_all(hash_list) if hash_list.any?

      Resolution.synchronize(pull_requests_by_github_api)
    end
  end

  def assignee?(user)
    assignees.include?(user)
  end

  def reviewer?(user)
    reviewers.include?(user)
  end
end
