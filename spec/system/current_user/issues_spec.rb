# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CurrentUser::Issues', type: :system do
  context 'ゲストの場合' do
    scenario 'トップページへリダイレクトする' do
      visit current_user_issues_path
      expect(page).to have_content 'ログインしてください'
      expect(page).to have_current_path root_path
    end
  end

  context 'ユーザーの場合' do
    scenario '本人が作成した Issue を一覧表示する' do
      create(:repository, id: 123, name: 'test/repository')

      kimura = create(:user, login: 'kimura')
      create(:issue, repository_id: 123, title: 'Issue A', author: kimura)
      create(:issue, repository_id: 123, title: 'Issue B', author: kimura)

      login_as kimura, to: current_user_issues_path

      expect(page).to have_content 'Total 2'
      expect(page).to have_link 'Issue A'
      expect(page).to have_link 'Issue B'
    end

    scenario '本人が担当した Issue を一覧表示する' do
      create(:repository, id: 123, name: 'test/repository')
      kimura = create(:user, login: 'kimura')
      create(:issue, :with_author, repository_id: 123, title: 'Issue C') { |issue| issue.assignees << kimura }
      create(:issue, :with_author, repository_id: 123, title: 'Issue D') { |issue| issue.assignees << kimura }

      login_as kimura, to: current_user_issues_path(association: 'assigned')

      expect(page).to have_content 'Total 2'
      expect(page).to have_link 'Issue C'
      expect(page).to have_link 'Issue D'
    end

    scenario '本人がレビューした Issue を一覧表示する' do
      create(:repository, id: 123, name: 'test/repository')
      kimura = create(:user, login: 'kimura')
      kimura_reviewed_pr = create(:pull_request, repository_id: 123) { |pr| pr.reviewers << kimura }
      create(:issue, :with_author, repository_id: 123, title: 'Issue E') { |issue| issue.pull_requests << kimura_reviewed_pr }
      create(:issue, :with_author, repository_id: 123, title: 'Issue F') { |issue| issue.pull_requests << kimura_reviewed_pr }

      login_as kimura, to: current_user_issues_path(association: 'reviewed')

      expect(page).to have_content 'Total 2'
      expect(page).to have_link 'Issue E'
      expect(page).to have_link 'Issue F'
    end
  end
end
