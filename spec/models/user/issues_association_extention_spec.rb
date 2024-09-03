# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::IssuesAssociationExtension do
  describe '#not_referenced_by_other_users' do
    context 'ユーザーが作成者である Issue の内 (has_many :issues)' do
      let(:repository) { create(:repository, id: 123) }
      let(:taro) { create(:user, id: 456, login: 'taro') }
      let(:jiro) { create(:user, id: 789, login: 'jiro') }

      # 以下は「他のユーザーが参照していない Issue を返すこと」を個別にテストしている

      it '他のユーザーが作成者でない Issue を返すこと' do
        create(:issue, repository:, id: 100, author: taro)
        create(:issue, repository:, id: 200, author: jiro)

        actual = taro.issues.not_referenced_by_other_users.ids
        expect(actual).to eq [100]
      end

      it '他のユーザーがアサインしていない Issue を返すこと' do
        create(:issue, repository:, id: 100, author: taro)
        create(:issue, repository:, id: 200, author: taro) { |issue| issue.assignees << jiro }

        actual = taro.issues.not_referenced_by_other_users.ids
        expect(actual).to eq [100]
      end

      it '他のユーザーがアサインしていない Issue を返すこと (Issue に関連する PullRequest にアサイン)' do
        create(:issue, repository:, id: 100, author: taro)
        create(:issue, repository:, id: 200, author: taro) do |issue|
          issue.pull_requests << create(:pull_request, repository:) { |pr| pr.assignees << jiro }
        end

        actual = taro.issues.not_referenced_by_other_users.ids
        expect(actual).to eq [100]
      end

      it '他のユーザーがレビューしていない Issue を返すこと' do
        create(:issue, repository:, id: 100, author: taro)
        create(:issue, repository:, id: 200, author: taro) do |issue|
          issue.pull_requests << create(:pull_request, repository:) { |pr| pr.reviewers << jiro }
        end

        actual = taro.issues.not_referenced_by_other_users.ids
        expect(actual).to eq [100]
      end
    end
  end
end
