# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PullRequestDecorator do
  describe '#url' do
    it '「環境変数に設定したGitHubのURL/リポジトリ名/pull/PullRequestのナンバー」に変換した URL を返すこと' do
      create(:repository, id: 123, name: 'test/repository')
      pull_request = create(:pull_request, repository_id: 123, number: 456)
      decorator_pull_request = ActiveDecorator::Decorator.instance.decorate(pull_request)

      expect(decorator_pull_request.url).to eq 'https://example.com/test/repository/pull/456'
    end
  end
end
