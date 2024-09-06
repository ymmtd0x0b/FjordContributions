# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IssueDecorator do
  describe '#point' do
    before do
      create(:repository, id: 123)
    end

    context 'Issue にラベルが貼られていない場合' do
      it 'ゼロを返すこと' do
        issue = create(:issue, :with_author, repository_id: 123)

        decorator_issue = ActiveDecorator::Decorator.instance.decorate(issue)
        expect(decorator_issue.point).to eq 0
      end
    end

    context 'Issue にラベルが貼られている場合' do
      it 'ストーリーポイントとなるラベルがあれば、そのポイントを返すこと' do
        issue = create(:issue, :with_author, repository_id: 123)
        issue.labels << create(:label, repository_id: 123, name: '1')
        issue.labels << create(:label, repository_id: 123, name: 'good first issue')

        decorator_issue = ActiveDecorator::Decorator.instance.decorate(issue)
        expect(decorator_issue.point).to eq 1
      end

      it 'ストーリーポイントとなるラベルがなけれが、ゼロを返すこと' do
        issue = create(:issue, :with_author, repository_id: 123)
        issue.labels << create(:label, repository_id: 123, name: 'good first issue')

        decorator_issue = ActiveDecorator::Decorator.instance.decorate(issue)
        expect(decorator_issue.point).to eq 0
      end
    end
  end

  describe '#url' do
    it '「環境変数(dotenv)に設定したGitHubのURL + リポジトリ名 + issues + Issueのナンバー」に変換した URL を返すこと' do
      create(:repository, id: 123, name: 'test/repository')
      issue = create(:issue, :with_author, repository_id: 123, number: 456)
      decorator_issue = ActiveDecorator::Decorator.instance.decorate(issue)

      expect(decorator_issue.url).to eq 'https://example.com/test/repository/issues/456'
    end
  end
end
