# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Issue, type: :model do
  it '有効なファクトリを持つこと' do
    issue = build(:issue, :with_author, :with_repository)
    expect(issue).to be_valid
  end
end
