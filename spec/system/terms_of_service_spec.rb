# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TermsOfService', type: :system do
  context 'ゲストの場合' do
    scenario '利用規約を表示する' do
      visit '/terms_of_service'
      expect(page).to have_element('h1', text: '利用規約')
    end
  end

  context 'ユーザーの場合' do
    scenario '利用規約を表示する' do
      create(:repository, name: 'test/repository')
      kimura = create(:user, login: 'kimura')

      login_as kimura, to: '/terms_of_service'
      expect(page).to have_element('h1', text: '利用規約')
    end
  end
end
