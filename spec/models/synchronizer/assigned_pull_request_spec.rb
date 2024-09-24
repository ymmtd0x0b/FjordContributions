# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Synchronizer::AssignedPullRequest, type: :model do
  describe '#call' do
    before do
      allow(GitHub::PullRequest).to receive(:assigned_by)
      allow(PullRequest).to receive(:synchronize)
      allow(Assign).to receive(:synchronize)
    end

    let(:synchronizer) { Synchronizer::AssignedPullRequest.new }
    let(:repository) { create(:repository) }
    let(:user) { create(:user) }

    it 'GitHubから対象の PullRequest を取得する(処理を呼び出す)こと' do
      synchronizer.call({ repository:, user: })
      expect(GitHub::PullRequest).to have_received(:assigned_by)
    end

    it '取得したデータをデータベースへ同期させる(処理を呼び出す)こと' do
      synchronizer.call({ repository:, user: })
      expect(PullRequest).to have_received(:synchronize)
    end

    it '取得したデータとユーザーのアソシエーション(Assign)を同期させる(処理を呼び出す)こと' do
      synchronizer.call({ repository:, user: })
      expect(Assign).to have_received(:synchronize)
    end
  end
end
