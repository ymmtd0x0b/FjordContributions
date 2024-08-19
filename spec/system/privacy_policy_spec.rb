# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PrivacyPolicy', type: :system do
  scenario 'プライバシーポリシーを表示する' do
    visit '/privacy_policy'
    expect(page).to have_element('h1', text: 'プライバシーポリシー')
  end
end
