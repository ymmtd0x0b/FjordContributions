# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User::Wikis', type: :system do
  scenario 'ユーザーが作成した Wiki を一覧表示する' do
    create(:repository, id: 123, name: 'test/repository')

    kimura = create(:user, login: 'kimura')
    create(:wiki, :with_author, :with_repository, repository_id: 123, title: '議事録01', author: kimura)
    create(:wiki, :with_author, :with_repository, repository_id: 123, title: '議事録02', author: kimura)
    create(:wiki, :with_author, :with_repository, repository_id: 123, title: '議事録03', author: kimura)

    visit users_wikis_path(kimura.login)

    expect(page).to have_content '議事録01'
    expect(page).to have_content '議事録02'
    expect(page).to have_content '議事録03'
  end
end
