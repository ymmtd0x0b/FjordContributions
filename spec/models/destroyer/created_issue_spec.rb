# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Destroyer::CreatedIssue, type: :model do
  describe '#call' do
    let(:destroyer) { Destroyer::CreatedIssue.new }
    let(:repository) { create(:repository, id: 123) }
    let(:taro) { create(:user, login: 'taro') }
    let(:jiro) { create(:user, login: 'jiro') }
    let(:jiro_assigned_pr) { create(:pull_request, repository:) { |pr| pr.assignees << jiro } }
    let(:jiro_reviewed_pr) { create(:pull_request, repository:) { |pr| pr.reviewers << jiro } }

    it '他のユーザーから参照されていない「ユーザーが作成者である Issue 」を削除すること' do
      create(:issue, id: 1, repository:, author: taro)
      create(:issue, id: 2, repository:, author: taro) { |issue| issue.assignees << jiro }
      create(:issue, id: 3, repository:, author: taro) { |issue| issue.pull_requests << jiro_assigned_pr }
      create(:issue, id: 4, repository:, author: taro) { |issue| issue.pull_requests << jiro_reviewed_pr }

      expect { destroyer.call(taro) }.to change { taro.issues.count }.by(-1)
                                     .and change { Issue.exists?(id: 1) }.from(true).to(false)
    end
  end
end
