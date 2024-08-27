# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User::Contributions', type: :system do
  scenario 'ユーザーの 作成/担当/レビューした Issue とそれと紐付いた PullRequest 、Wiki を一覧表示する' do
    create(:repository, id: 123, name: 'test/repository')
    kimura = create(:user, login: 'kimura')

    create(:issue, :with_author, :with_repository, repository_id: 123, title: 'キムラが担当した Issue') do |issue|
      issue.assignees << kimura
      issue.pull_requests << create(:pull_request, :with_repository, repository_id: 123, number: 111) { |pr| pr.assignees << kimura }
    end

    create(:issue, :with_author, :with_repository, repository_id: 123, title: 'キムラがレビューした Issue') do |issue|
      issue.pull_requests << create(:pull_request, :with_repository, repository_id: 123, number: 222) { |pr| pr.reviewers << kimura }
    end

    create(:issue, :with_author, :with_repository, repository_id: 123, title: 'キムラが作成した Issue', author: kimura)
    create(:wiki, :with_repository, repository_id: 123, title: 'キムラが作成した Wiki', author: kimura)

    visit users_contributions_path(kimura.login)

    expect(page).to have_button('Markdown をコピー')
    expect(page).to have_button('URL をコピー')
    expect(page).to have_content('キムラが担当した Issue')
    expect(page).to have_content('#111')
    expect(page).to have_content('キムラがレビューした Issue')
    expect(page).to have_content('#222')
    expect(page).to have_content('キムラが作成した Issue')
    expect(page).to have_content('キムラが作成した Wiki')
  end
end
