# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IssueDecorator do
  describe '#point' do
    before do
      create(:repository, id: 123)
    end

    context 'Issue にラベルが貼られていない場合' do
      it 'ゼロを返すこと' do
        issue = create(:issue, :with_author, :with_repository, repository_id: 123)

        decorator_issue = ActiveDecorator::Decorator.instance.decorate(issue)
        expect(decorator_issue.point).to eq 0
      end
    end

    context 'Issue にラベルが貼られている場合' do
      it 'ストーリーポイントとなるラベルがあれば、そのポイントを返すこと' do
        issue = create(:issue, :with_author, :with_repository, repository_id: 123)
        issue.labels << create(:label, :with_repository, repository_id: 123, name: '1')
        issue.labels << create(:label, :with_repository, repository_id: 123, name: 'good first issue')

        decorator_issue = ActiveDecorator::Decorator.instance.decorate(issue)
        expect(decorator_issue.point).to eq 1
      end

      it 'ストーリーポイントとなるラベルがなけれが、ゼロを返すこと' do
        issue = create(:issue, :with_author, :with_repository, repository_id: 123)
        issue.labels << create(:label, :with_repository, repository_id: 123, name: 'good first issue')

        decorator_issue = ActiveDecorator::Decorator.instance.decorate(issue)
        expect(decorator_issue.point).to eq 0
      end
    end
  end
end
