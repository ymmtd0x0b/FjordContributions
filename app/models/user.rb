# frozen_string_literal: true

class User < ApplicationRecord
  validates :login, presence: true

  has_many :issues, foreign_key: :author_id, inverse_of: :author, extend: IssuesAssociationExtension # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :wikis, foreign_key: :author_id, inverse_of: :author, dependent: :destroy

  has_many :assigns, dependent: :destroy
  has_many :assigned_issues, through: :assigns, source: :assignable, source_type: 'Issue', extend: IssuesAssociationExtension
  has_many :assigned_pull_requests, through: :assigns, source: :assignable, source_type: 'PullRequest', extend: PullRequestsAssociationExtension

  has_many :reviews, dependent: :destroy
  has_many :reviewed_pull_requests, through: :reviews, source: :pull_request, extend: PullRequestsAssociationExtension
  has_many :reviewed_issues, through: :reviewed_pull_requests, source: :issues, extend: IssuesAssociationExtension

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
