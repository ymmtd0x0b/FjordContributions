# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Label, type: :model do
  it '有効なファクトリを持つこと' do
    label = build(:label, :with_repository)
    expect(label).to be_valid
  end
end
