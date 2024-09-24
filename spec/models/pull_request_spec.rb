# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PullRequest, type: :model do
  it '有効なファクトリを持つこと' do
    pull_request = build(:pull_request, :with_repository)
    expect(pull_request).to be_valid
  end

  describe '.synchronize' do
    before do
      create(:repository, id: 123)
      allow(Resolution).to receive(:synchronize)
    end

    context '引数の中に「未登録のPullRequest」がある場合' do
      it '新たに登録すること' do
        create(:pull_request, repository_id: 123, id: 100, number: 10)
        pull_requests_collected_by_the_github_api = [
          GitHub::PullRequest.new(repository_id: 123,
                                  pull_request: { id: 100, number: 10, issues_number: [],
                                                  created_at: '2000/01/01 09:00:00', updated_at: '2000/01/01 10:00:00' }),
          GitHub::PullRequest.new(repository_id: 123,
                                  pull_request: { id: 200, number: 20, issues_number: [],
                                                  created_at: '2000/01/01 09:00:00', updated_at: '2000/01/01 10:00:00' })
        ]

        expect { PullRequest.synchronize(pull_requests_collected_by_the_github_api) }.to change { PullRequest.count }.from(1).to(2)
      end
    end

    context '引数の中に「登録済みのPullRequest」がある場合' do
      it '該当 PullRequest を更新すること' do
        pull_request = create(:pull_request, repository_id: 123, id: 100, number: 10)
        pull_requests_collected_by_the_github_api = [
          GitHub::PullRequest.new(repository_id: 123,
                                  pull_request: { id: 100, number: 99, issues_number: [],
                                                  created_at: '2000/01/01 09:00:00', updated_at: '2000/01/01 10:00:00' })
        ]

        expect { PullRequest.synchronize(pull_requests_collected_by_the_github_api) }.to change { pull_request.reload.number }.from(10).to(99)
      end
    end

    it 'PullRequest の description にリンクされた Issue とのアソシエーションを同期させる(メソッドを呼び出す)こと' do
      PullRequest.synchronize([])
      expect(Resolution).to have_received(:synchronize)
    end
  end

  describe '#assignee?' do
    before do
      create(:repository, id: 123)
    end

    context 'ユーザーがアサインされている場合' do
      it 'true を返すこと' do
        kimura = create(:user, login: 'kimura')
        pull_request = create(:pull_request, repository_id: 123) { |pr| pr.assignees << kimura }

        expect(pull_request.assignee?(kimura)).to eq true
      end
    end

    context 'ユーザーがアサインされていない場合' do
      it 'false を返すこと' do
        kimura = create(:user, login: 'kimura')
        hajime = create(:user, login: 'hajime')
        pull_request = create(:pull_request, repository_id: 123) { |pr| pr.assignees << hajime }

        expect(pull_request.assignee?(kimura)).to eq false
      end
    end
  end

  describe '#reviewer?' do
    before do
      create(:repository, id: 123)
    end

    context 'ユーザーがレビューしている場合' do
      it 'true を返すこと' do
        kimura = create(:user, login: 'kimura')
        pull_request = create(:pull_request, repository_id: 123) { |pr| pr.reviewers << kimura }

        expect(pull_request.reviewer?(kimura)).to eq true
      end
    end

    context 'ユーザーがレビューしていない場合' do
      it 'false を返すこと' do
        kimura = create(:user, login: 'kimura')
        hajime = create(:user, login: 'hajime')
        pull_request = create(:pull_request, repository_id: 123) { |pr| pr.reviewers << hajime }

        expect(pull_request.reviewer?(kimura)).to eq false
      end
    end
  end
end
