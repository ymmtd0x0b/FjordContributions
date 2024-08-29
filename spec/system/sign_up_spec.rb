# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sign up', type: :system do
  before do
    create(:repository, id: 123, name: 'test/repository')
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

  context 'ゲストとして、ログインボタンをクリックした場合' do
    scenario 'ユーザー登録する' do
      visit root_path
      expect do
        click_button 'ログイン'
        expect(page).to have_current_path '/kimura/issues?association=assigned'
        expect(page).to have_content 'kimura'
      end.to change { User.count }.from(0).to(1)
    end
  end
end
