# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repository, type: :model do
  it '有効なファクトリを持つこと' do
    repository = build(:repository)
    expect(repository).to be_valid
  end
end
