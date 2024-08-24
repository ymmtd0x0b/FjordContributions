# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User::Issues', type: :system do
  scenario 'ユーザーが作成した Issue を一覧表示する' do
    create(:repository, id: 123, name: 'test/repository')
    create(:user, login: 'kimura') do |kimura|
      create(:issue, :with_author, :with_repository, repository_id: 123, title: 'Issue A', author: kimura)
      create(:issue, :with_author, :with_repository, repository_id: 123, title: 'Issue B', author: kimura)
    end

    visit users_issues_path('kimura')

    expect(page).to have_content 'Total 2'
    expect(page).to have_content 'Issue A'
    expect(page).to have_content 'Issue B'
  end
end
