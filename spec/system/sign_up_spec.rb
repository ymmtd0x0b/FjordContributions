# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sign up', type: :system do
  before do
    create(:repository, id: 123, name: 'test/repository') do |repository|
      create(:label, repository:, id: 201, name: '1')
      create(:label, repository:, id: 202, name: '2')
      create(:label, repository:, id: 203, name: '3')
      create(:label, repository:, id: 204, name: 'bug')
      create(:label, repository:, id: 205, name: '新機能')
    end
    OmniAuth.config.mock_auth[:github] =
      OmniAuth::AuthHash.new({ provider: 'github', uid: 501, info: { nickname: 'kimura', name: '', image: 'https://example.com/avatar.png' } })
  end

  scenario 'ユーザー登録する' do
    visit root_path
    expect do
      click_button 'GitHubアカウントで登録'
      expect(page).to have_content 'アカウント登録が完了しました'
      expect(page).to have_current_path current_user_issues_path(association: 'assigned')
      expect(page).to have_content 'kimura'
    end.to change { User.count }.from(0).to(1)
  end

  context 'ゲストがログインボタンをクリックした場合' do
    scenario 'ユーザー登録する' do
      visit root_path
      expect do
        click_button 'ログイン'
        expect(page).to have_content 'アカウント登録が完了しました'
        expect(page).to have_current_path current_user_issues_path(association: 'assigned')
        expect(page).to have_content 'kimura'
      end.to change { User.count }.from(0).to(1)
    end
  end

  context 'ユーザー登録した際' do
    scenario 'モーダル(歓迎メッセージ)を表示すること' do
      visit root_path
      click_button 'GitHubアカウントで登録'

      expect(page).to have_content 'ようこそ！'
      expect(page).to have_button '今すぐあなたの取り組みを取得する'
      expect(page).to have_button '後で'
    end

    scenario 'モーダル内のから「今すぐあなたの取り組みを取得する」をクリックすると GitHub から情報を取得すること', vcr: { cassette_name: 'system/sign_up' } do
      DummyRepositoryWiki.init('test/repository', files: %w[議事録１ 議事録２], author: 'kimura') do |tmpdir_realpath|
        allow(Git::Wiki).to receive(:github_url).and_return(tmpdir_realpath)

        visit root_path
        click_button 'GitHubアカウントで登録'

        click_button '今すぐあなたの取り組みを取得する'
        expect(page).to have_content '更新に成功しました'

        visit current_user_contributions_path

        within('#assigned_issues') do
          expect(page).to have_content '1'
          expect(page).to have_link 'バグの修正'
          expect(page).to have_link '#401'
          expect(page).to have_content '2'
          expect(page).to have_link '新機能の追加'
          expect(page).to have_link '#402'
          expect(page).to have_content '3'
        end

        within('#reviewed_issues') do
          expect(page).to have_content '2'
          expect(page).to have_link 'ロゴの変更'
          expect(page).to have_content '3'
          expect(page).to have_link '既存機能の改修'
          expect(page).to have_content '5'
        end

        within('#created_issues') do
          expect(page).to have_link 'バグの報告１'
          expect(page).to have_link 'バグの報告２'
          expect(page).to have_link '新機能の提案'
        end

        within('#created_wikis') do
          expect(page).to have_link '議事録１'
          expect(page).to have_link '議事録２'
        end
      end
    end
  end
end
