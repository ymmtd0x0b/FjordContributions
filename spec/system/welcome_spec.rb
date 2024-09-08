# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcome', type: :system do
  context 'ゲストの場合' do
    scenario 'Welcome ページを表示する' do
      visit root_path
      expect(page).to have_element('h1', text: '登録するだけであなたの取り組みを一覧表示')
      expect(page).to have_button('GitHubアカントで登録')
    end
  end

  context 'ユーザーの場合' do
    scenario '本人がアサインした Issue の一覧ページへリダイレクトする' do
      create(:repository, name: 'test/repository')
      kimura = create(:user, login: 'kimura')

      login_as kimura, to: root_path
      expect(page).to have_current_path current_user_issues_path(association: 'assigned')
    end
  end
end
