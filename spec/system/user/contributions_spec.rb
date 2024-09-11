# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User::Contributions', type: :system do
  before do
    create(:repository, id: 123, name: 'test/repository')
    create(:issue, :with_author, repository_id: 123, title: 'キムラが担当した Issue') do |issue|
      issue.assignees << kimura
      issue.pull_requests << create(:pull_request, repository_id: 123, number: 111) { |pr| pr.assignees << kimura }
    end
    create(:issue, :with_author, repository_id: 123, title: 'キムラがレビューした Issue') do |issue|
      issue.pull_requests << create(:pull_request, repository_id: 123, number: 222) { |pr| pr.reviewers << kimura }
    end
    create(:issue, repository_id: 123, title: 'キムラが作成した Issue', author: kimura)
    create(:wiki, repository_id: 123, title: 'キムラが作成した Wiki', author: kimura)
  end

  let!(:kimura) { create(:user, login: 'kimura', avatar_url: 'https://example.com/avatar_url.png') }

  context 'ゲストの場合' do
    scenario 'ユーザーの 作成/担当/レビューした Issue とそれと紐付いた PullRequest 、Wiki を一覧表示する' do
      login_as kimura, to: users_contributions_path('kimura')

      expect(page).to have_content('チーム開発プラクティスでの kimura さんの取り組み', normalize_ws: true)

      expect(page).not_to have_content('Markdown をコピー')
      expect(page).not_to have_content('URL をコピー')

      within('#assigned_issues') do
        expect(page).to have_link('キムラが担当した Issue')
        expect(page).to have_link('#111')
      end

      within('#reviewed_issues') do
        expect(page).to have_link('キムラがレビューした Issue')
        expect(page).to have_link('#222')
      end

      within('#created_issues') do
        expect(page).to have_link('キムラが作成した Issue')
      end

      within('#created_wikis') do
        expect(page).to have_link('キムラが作成した Wiki')
      end
    end
  end

  context 'ユーザーの場合' do
    scenario 'ユーザーの 作成/担当/レビューした Issue とそれと紐付いた PullRequest 、Wiki を一覧表示する' do
      login_as kimura, to: users_contributions_path('kimura')

      expect(page).to have_content('チーム開発プラクティスでの kimura さんの取り組み', normalize_ws: true)

      expect(page).not_to have_button('Markdown をコピー')
      expect(page).not_to have_button('URL をコピー')

      within('#assigned_issues') do
        expect(page).to have_link('キムラが担当した Issue')
        expect(page).to have_link('#111')
      end

      within('#reviewed_issues') do
        expect(page).to have_link('キムラがレビューした Issue')
        expect(page).to have_link('#222')
      end

      within('#created_issues') do
        expect(page).to have_link('キムラが作成した Issue')
      end

      within('#created_wikis') do
        expect(page).to have_link('キムラが作成した Wiki')
      end
    end
  end
end
