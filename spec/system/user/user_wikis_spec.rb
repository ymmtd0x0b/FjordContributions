# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User::Wikis', type: :system do
  context 'ゲストの場合' do
    scenario 'トップページへリダイレクトする' do
      visit users_wikis_path('kimura')
      expect(page).to have_content 'ログインしてください'
      expect(page).to have_current_path root_path
    end
  end

  context 'ユーザーの場合' do
    scenario 'ユーザーが作成した Wiki を一覧表示する' do
      create(:repository, id: 123, name: 'test/repository')

      kimura = create(:user, login: 'kimura')
      create(:wiki, repository_id: 123, title: '議事録01', author: kimura)
      create(:wiki, repository_id: 123, title: '議事録02', author: kimura)
      create(:wiki, repository_id: 123, title: '議事録03', author: kimura)

      login_as kimura, to: users_wikis_path(kimura.login)

      expect(page).to have_link '議事録01'
      expect(page).to have_link '議事録02'
      expect(page).to have_link '議事録03'
    end
  end
end
