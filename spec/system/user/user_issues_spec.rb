# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User::Issues', type: :system do
  scenario 'ユーザーが作成した Issue を一覧表示する' do
    create(:repository, id: 123, name: 'test/repository')
    create(:user, login: 'kimura') do |kimura|
      create(:issue, repository_id: 123, title: 'Issue A', author: kimura)
      create(:issue, repository_id: 123, title: 'Issue B', author: kimura)
    end

    visit users_issues_path('kimura')

    expect(page).to have_content 'Total 2'
    expect(page).to have_content 'Issue A'
    expect(page).to have_content 'Issue B'
  end

  scenario 'ユーザーが担当した Issue を一覧表示する' do
    create(:repository, id: 123, name: 'test/repository')
    create(:user, login: 'kimura') do |kimura|
      create(:issue, :with_author, repository_id: 123, title: 'Issue C') { |issue| issue.assignees << kimura }
      create(:issue, :with_author, repository_id: 123, title: 'Issue D') { |issue| issue.assignees << kimura }
    end

    visit users_issues_path('kimura', association: 'assigned')

    expect(page).to have_content 'Total 2'
    expect(page).to have_content 'Issue C'
    expect(page).to have_content 'Issue D'
  end

  scenario 'ユーザーがレビューした Issue を一覧表示する' do
    create(:repository, id: 123, name: 'test/repository')
    create(:user, login: 'kimura') do |kimura|
      create(:issue, :with_author, repository_id: 123, title: 'Issue E') do |issue|
        issue.pull_requests << create(:pull_request, repository_id: 123) { |pr| pr.reviewers << kimura }
      end
      create(:issue, :with_author, repository_id: 123, title: 'Issue F') do |issue|
        issue.pull_requests << create(:pull_request, repository_id: 123) { |pr| pr.reviewers << kimura }
      end
    end

    visit users_issues_path('kimura', association: 'reviewed')

    expect(page).to have_content 'Total 2'
    expect(page).to have_content 'Issue E'
    expect(page).to have_content 'Issue F'
  end
end
