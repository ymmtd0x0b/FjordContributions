# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::PullRequestsAssociationExtension do
  describe '#assigned_pull_requests.not_referenced_by_other_users' do
    context 'ユーザーがアサインしている PullRequest の内 (has_may :assigned_pull_requests)' do
      let(:repository) { create(:repository) }
      let(:taro) { create(:user, login: 'taro') }
      let(:jiro) { create(:user, login: 'jiro') }

      # 以下は「他のユーザーが参照していない PullRequest を返すこと」を個別にテストしている

      it '他のユーザーがアサインしていない PullRequest を返すこと' do
        taro.assigned_pull_requests << [
          create(:pull_request, repository:, id: 100),
          create(:pull_request, repository:, id: 200) { |pr| pr.assignees << jiro }
        ]

        actual = taro.assigned_pull_requests.not_referenced_by_other_users.ids
        expect(actual).to eq [100]
      end

      it '他のユーザーがレビューしていない PullRequest を返すこと' do
        taro.assigned_pull_requests << [
          create(:pull_request, repository:, id: 100),
          create(:pull_request, repository:, id: 200) { |pr| pr.reviewers << jiro }
        ]

        actual = taro.assigned_pull_requests.not_referenced_by_other_users.ids
        expect(actual).to eq [100]
      end
    end
  end
end
