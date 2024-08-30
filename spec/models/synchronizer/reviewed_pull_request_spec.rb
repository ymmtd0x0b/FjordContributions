# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Synchronizer::ReviewedPullRequest, type: :model do
  describe '#call' do
    before do
      allow(GitHub::PullRequest).to receive(:reviewed_by)
      allow(PullRequest).to receive(:synchronize)
      allow(Review).to receive(:synchronize)
    end

    let(:synchronizer) { Synchronizer::ReviewedPullRequest.new }
    let(:repository) { create(:repository) }
    let(:user) { create(:user) }

    it 'GitHubから対象の PullRequest を取得する(処理を呼び出す)こと' do
      synchronizer.call({ repository:, user: })
      expect(GitHub::PullRequest).to have_received(:reviewed_by)
    end

    it '取得したデータをデータベースへ同期させる(処理を呼び出す)こと' do
      synchronizer.call({ repository:, user: })
      expect(PullRequest).to have_received(:synchronize)
    end

    it '取得したデータとユーザーのアソシエーション(Review)を同期させる(処理を呼び出す)こと' do
      synchronizer.call({ repository:, user: })
      expect(Review).to have_received(:synchronize)
    end
  end
end
