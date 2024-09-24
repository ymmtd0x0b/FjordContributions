# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Destroyer::ReviewedPullRequest, type: :model do
  describe '#call' do
    let(:repository) { create(:repository) }
    let(:taro) { create(:user, login: 'taro') }
    let(:jiro) { create(:user, login: 'jiro') }

    it '他のユーザーから参照されていない「ユーザーがレビューしている PullRequest 」を削除すること' do
      taro.reviewed_pull_requests << [
        create(:pull_request, id: 1, repository:),
        create(:pull_request, id: 2, repository:) { |pr| pr.assignees << jiro },
        create(:pull_request, id: 3, repository:) { |pr| pr.reviewers << jiro }
      ]

      destroyer = Destroyer::ReviewedPullRequest.new
      expect { destroyer.call(taro) }.to change { taro.reviewed_pull_requests.count }.by(-1)
                                     .and change { PullRequest.exists?(id: 1) }.from(true).to(false)
    end
  end
end
