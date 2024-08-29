# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'LoginAndLogout', type: :system do
  before do
    create(:repository, id: 123)
    OmniAuth.config.mock_auth[:github] =
      OmniAuth::AuthHash.new({ provider: 'github', uid: 456, info: { nickname: 'kimura', name: '', image: 'https://example.com/avatar.png' } })
  end

  scenario 'ログインに成功すること' do
    create(:user, id: 456, login: 'kimura')

    visit root_path
    click_button 'ログイン'

    expect(page).to have_current_path '/kimura/issues?association=assigned'
    expect(page).to have_button 'kimura'
  end

  context 'ユーザーがアカウント登録ボタンをクリックした場合' do
    scenario 'ログインに成功すること' do
      create(:user, id: 456, login: 'kimura')

      visit root_path
      click_button 'GitHubアカントで登録'

      expect(page).to have_current_path '/kimura/issues?association=assigned'
      expect(page).to have_button 'kimura'
    end
  end

  scenario 'ログアウトに成功すること' do
    kimura = create(:user, id: 456, login: 'kimura')

    login_as kimura, to: root_path

    click_button 'kimura'
    click_link 'ログアウト'

    expect(page).to have_current_path root_path
    expect(page).to have_button 'ログイン'
  end
end
