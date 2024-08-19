# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TermsOfService', type: :system do
  scenario '利用規約を表示する' do
    visit '/terms_of_service'
    expect(page).to have_element('h1', text: '利用規約')
  end
end
