# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WikiDecorator do
  describe '#url' do
    it '「環境変数(dotenv)に設定したGitHubのURL + リポジトリ名 + wiki + Wikiのタイトル」に変換した URL を返すこと' do
      create(:repository, id: 123, name: 'test/repository')
      wiki = create(:wiki, :with_author, repository_id: 123, title: '議事録#001')
      decorator_wiki = ActiveDecorator::Decorator.instance.decorate(wiki)

      expect(decorator_wiki.url).to eq 'https://example.com/test/repository/wiki/議事録#001'
    end
  end
end
