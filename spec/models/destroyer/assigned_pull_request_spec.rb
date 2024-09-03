# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Destroyer::AssignedPullRequest, type: :model do
  describe '#call' do
    let(:repository) { create(:repository) }
    let(:taro) { create(:user, login: 'taro') }
    let(:jiro) { create(:user, login: 'jiro') }

    it '他のユーザーから参照されていない「ユーザーがアサインしている PullRequest 」を削除すること' do
      taro.assigned_pull_requests << [
        create(:pull_request, repository:),
        create(:pull_request, repository:) { |pr| pr.assignees << jiro },
        create(:pull_request, repository:) { |pr| pr.reviewers << jiro }
      ]

      destroyer = Destroyer::AssignedPullRequest.new
      expect { destroyer.call(taro) }.to change { taro.assigned_pull_requests.count }.from(3).to(2)
    end
  end
end
