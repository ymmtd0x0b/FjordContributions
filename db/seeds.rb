# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 既存のデータを削除
Repository.destroy_all
Label.destroy_all
User.destroy_all
Issue.destroy_all
Assign.destroy_all
PullRequest.destroy_all

# 初期データの投入
repo_by_api = GitHub::Repository.find_by(name: 'fjordllc/bootcamp')
repository = Repository.create!(repo_by_api.to_h)

labels_by_api = GitHub::Label.registered_by(repository)
labels_by_api.each { |label| Label.create!(label.to_h) }

user_by_api = GitHub::User.find_by(login: ENV['USER_LOGIN'])
user = User.create!(user_by_api.to_h)

created_issues = GitHub::Issue.created_by(repository, user)
created_issues.each { |issue| Issue.create!(issue.to_h) }

assigned_issues = GitHub::Issue.assigned_by(repository, user)
assigned_issues.each do |issue|
  Issue.create!(issue.to_h) unless Issue.find_by(id: issue.id)
  Assign.create!(assignable_type: 'Issue', assignable_id: issue.id, user:)
end

assigned_pull_requests = GitHub::PullRequest.assigned_by(repository, user)
assigned_pull_requests.each do |pull_request|
  PullRequest.create!(pull_request.to_h)
  Assign.create!(assignable_type: 'PullRequest', assignable_id: pull_request.id, user:)
end
