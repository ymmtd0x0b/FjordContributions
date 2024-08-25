# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PullRequest, type: :model do
  it '有効なファクトリを持つこと' do
    pull_request = build(:pull_request, :with_repository)
    expect(pull_request).to be_valid
  end
end
