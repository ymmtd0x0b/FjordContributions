# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Destroyer::AssignedIssue, type: :model do
  describe '#call' do
    let(:repository) { create(:repository, id: 123) }
    let(:taro) { create(:user, login: 'taro') }
    let(:jiro) { create(:user, login: 'jiro') }
    let(:jiro_assigned_pr) { create(:pull_request, repository:) { |pr| pr.assignees << jiro } }
    let(:jiro_reviewed_pr) { create(:pull_request, repository:) { |pr| pr.reviewers << jiro } }

    it '他のユーザーから参照されていない「ユーザーがアサインしている Issue 」を削除すること' do
      taro.assigned_issues << [
        create(:issue, repository:, author_id: 0),
        create(:issue, repository:, author: jiro),
        create(:issue, repository:, author_id: 0) { |issue| issue.assignees << jiro },
        create(:issue, repository:, author_id: 0) { |issue| issue.pull_requests << jiro_assigned_pr },
        create(:issue, repository:, author_id: 0) { |issue| issue.pull_requests << jiro_reviewed_pr }
      ]

      destroyer = Destroyer::AssignedIssue.new
      expect { destroyer.call(taro) }.to change { taro.assigned_issues.count }.from(5).to(4)
    end
  end
end
