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
      click_button 'GitHubアカントで登録'
      expect(page).to have_current_path '/kimura/issues?association=assigned'
      expect(page).to have_content 'kimura'
    end.to change { User.count }.from(0).to(1)
  end

  context 'ゲストがログインボタンをクリックした場合' do
    scenario 'ユーザー登録する' do
      visit root_path
      expect do
        click_button 'ログイン'
        expect(page).to have_current_path '/kimura/issues?association=assigned'
        expect(page).to have_content 'kimura'
      end.to change { User.count }.from(0).to(1)
    end
  end

  scenario 'ユーザー登録する際、作成/担当した Issue を取得すること', vcr: { cassette_name: 'system/sign_up' } do
    visit root_path
    click_button 'GitHubアカントで登録'

    visit users_contributions_path('kimura')

    within('#assigned_issues') do
      expect(page).to have_content '1'
      expect(page).to have_content 'バグの修正'
      expect(page).to have_content '2'
      expect(page).to have_content '新機能の追加'
    end

    within('#created_issues') do
      expect(page).to have_content 'バグの報告１'
      expect(page).to have_content 'バグの報告２'
      expect(page).to have_content '新機能の提案'
    end
  end
end
