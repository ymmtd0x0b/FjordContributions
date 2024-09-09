# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'LoginAndLogout', type: :system do
  context 'OAuth認証に成功する場合' do
    before do
      create(:repository, id: 123)
      OmniAuth.config.mock_auth[:github] =
        OmniAuth::AuthHash.new({ provider: 'github', uid: 456, info: { nickname: 'kimura', name: '', image: 'https://example.com/avatar.png' } })
    end

    scenario 'ユーザーはログインできること' do
      create(:user, id: 456, login: 'kimura')

      visit root_path
      click_button 'ログイン'

      expect(page).to have_content 'ログインしました'
      expect(page).to have_current_path current_user_issues_path(association: 'assigned')
      expect(page).to have_button 'kimura'
    end

    scenario 'アカウント登録ボタンでも、ユーザーはログインできること' do
      create(:user, id: 456, login: 'kimura')

      visit root_path
      click_button 'GitHubアカウントで登録'

      expect(page).to have_content 'ログインしました'
      expect(page).to have_current_path current_user_issues_path(association: 'assigned')
      expect(page).to have_button 'kimura'
    end
  end

  context 'OAuth認証に失敗(もしくは認証画面でキャンセル)する場合' do
    scenario 'トップページへリダイレクトすること' do
      create(:repository, id: 123)
      OmniAuth.config.mock_auth[:github] = :invalid_credentials

      visit root_path
      click_button 'ログイン'

      expect(page).to have_content '認証に失敗しました'
      expect(page).to have_current_path root_path
    end
  end

  scenario 'ユーザーはログアウトできること' do
    kimura = create(:user, id: 456, login: 'kimura')

    login_as kimura, to: root_path

    click_button 'kimura'
    click_link 'ログアウト'

    expect(page).to have_content 'ログアウトしました'
    expect(page).to have_current_path root_path
    expect(page).to have_button 'ログイン'
  end
end
