# frozen_string_literal: true

class User < ApplicationRecord
  has_many :issues, foreign_key: :author_id, inverse_of: :author # rubocop:disable Rails/HasManyOrHasOneDependent

  has_many :assigns, dependent: :destroy
  has_many :assigned_issues, through: :assigns, source: :assignable, source_type: 'Issue'
  has_many :assigned_pull_requests, through: :assigns, source: :assignable, source_type: 'PullRequest'
end
