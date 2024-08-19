# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcome', type: :system do
  scenario 'Welcome ページを表示する' do
    visit root_path
    expect(page).to have_element('h1', text: '登録するだけであなたの取り組みを一覧表示')
    expect(page).to have_button('GitHubアカントで登録')
  end
end
