# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Issue, type: :model do
  it '有効なファクトリを持つこと' do
    issue = build(:issue, :with_repository)
    expect(issue).to be_valid
  end

  describe '.synchronize' do
    before do
      create(:repository, id: 123)
      allow(Labeling).to receive(:synchronize)
    end

    context '引数の中に「未登録の Issue 」がある場合' do
      it '新たに登録すること' do
        create(:issue, repository_id: 123, id: 100, title: 'issue#100', number: 100, author_id: 1)
        issues_collected_by_the_github_api = [
          GitHub::Issue.new(repository_id: 123, issue: { id: 100, user_id: 1, title: 'issue#100', number: 100, labels_id: [],
                                                         created_at: '2000-01-01 09:00:00', updated_at: '2000-01-01 09:00:00' }),
          GitHub::Issue.new(repository_id: 123, issue: { id: 200, user_id: 1, title: 'issue#200', number: 200, labels_id: [],
                                                         created_at: '2000-01-01 09:00:00', updated_at: '2000-01-01 09:00:00' })
        ]

        expect { Issue.synchronize(issues_collected_by_the_github_api) }.to change { Issue.count }.from(1).to(2)
      end
    end

    context '引数の中に「登録済みの Issue 」がある場合' do
      it '該当 Issue の情報を更新すること' do
        issue = create(:issue, repository_id: 123, id: 100, title: 'before update...', number: 100, author_id: 1)
        issues_collected_by_the_github_api = [
          GitHub::Issue.new(repository_id: 123, issue: { id: 100, user_id: 1, title: 'updated!', number: 100, labels_id: [],
                                                         created_at: '2000-01-01 09:00:00', updated_at: '2000-01-01 09:00:00' })
        ]

        expect { Issue.synchronize(issues_collected_by_the_github_api) }.to change { issue.reload.title }.from('before update...').to('updated!')
      end
    end

    it 'Issue のラベリングを同期させる(メソッドを呼び出す)こと' do
      Issue.synchronize([])
      expect(Labeling).to have_received(:synchronize)
    end
  end
end
