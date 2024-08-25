# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wiki, type: :model do
  it '有効なファクトリを持つこと' do
    wiki = build(:wiki, :with_repository, :with_author)
    expect(wiki).to be_valid
  end
end
