# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PrivacyPolicy', type: :system do
  context 'ゲストの場合' do
    scenario 'プライバシーポリシーを表示する' do
      visit '/privacy_policy'
      expect(page).to have_element('h1', text: 'プライバシーポリシー')
    end
  end

  context 'ユーザーの場合' do
    scenario 'プライバシーポリシーを表示する' do
      create(:repository, name: 'test/repository')
      kimura = create(:user, login: 'kimura')

      login_as kimura, to: '/privacy_policy'
      expect(page).to have_element('h1', text: 'プライバシーポリシー')
    end
  end
end
