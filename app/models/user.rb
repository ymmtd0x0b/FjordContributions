# frozen_string_literal: true

class User < ApplicationRecord
  has_many :issues, foreign_key: :author_id, inverse_of: :author # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :wikis, foreign_key: :author_id, inverse_of: :author, dependent: :destroy

  has_many :assigns, dependent: :destroy
  has_many :assigned_issues, through: :assigns, source: :assignable, source_type: 'Issue'
  has_many :assigned_pull_requests, through: :assigns, source: :assignable, source_type: 'PullRequest'

  has_many :reviews, dependent: :destroy
  has_many :reviewed_pull_requests, through: :reviews, source: :pull_request
  has_many :reviewed_issues, through: :reviewed_pull_requests, source: :issues

  def self.find_or_initialize_by_github_auth(auth_hash)
    uid = auth_hash[:uid]
    login = auth_hash[:info][:nickname]
    name = auth_hash[:info][:name]
    avatar_url = auth_hash[:info][:image]

    User.find_or_initialize_by(id: uid) do |user|
      user.id = uid
      user.login = login
      user.name = name
      user.avatar_url = avatar_url
    end
  end
end
