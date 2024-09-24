# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Destroyer::ReviewedIssue, type: :model do
  describe '#call' do
    let(:repository) { create(:repository, id: 123) }

    let(:taro) { create(:user, login: 'taro') }
    let(:taro_reviewed_pr) { create(:pull_request, repository:) { |pr| pr.reviewers << taro } }

    let(:jiro) { create(:user, login: 'jiro') }
    let(:jiro_assigned_pr) { create(:pull_request, repository:) { |pr| pr.assignees << jiro } }
    let(:jiro_reviewed_pr) { create(:pull_request, repository:) { |pr| pr.reviewers << jiro } }

    it '他のユーザーから参照されていない「ユーザーがレビューしている Issue 」を削除すること' do
      create(:issue, id: 1, repository:, author_id: 0) { |issue| issue.pull_requests << taro_reviewed_pr }
      create(:issue, id: 2, repository:, author: jiro) { |issue| issue.pull_requests << taro_reviewed_pr }
      jiro.assigned_issues << create(:issue, id: 3, repository:, author_id: 0) { |issue| issue.pull_requests << taro_reviewed_pr }
      create(:issue, id: 4, repository:, author_id: 0) { |issue| issue.pull_requests << [taro_reviewed_pr, jiro_assigned_pr] }
      create(:issue, id: 5, repository:, author_id: 0) { |issue| issue.pull_requests << [taro_reviewed_pr, jiro_reviewed_pr] }

      destroyer = Destroyer::ReviewedIssue.new
      expect { destroyer.call(taro) }.to change { taro.reviewed_issues.count }.by(-1)
                                     .and change { Issue.exists?(id: 1) }.from(true).to(false)
    end
  end
end
