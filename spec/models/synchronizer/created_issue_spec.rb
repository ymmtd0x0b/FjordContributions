# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Synchronizer::CreatedIssue, type: :model do
  describe '#call' do
    before do
      allow(GitHub::Issue).to receive(:created_by)
      allow(Issue).to receive(:synchronize)
    end

    let(:synchronizer) { Synchronizer::CreatedIssue.new }
    let(:repository) { create(:repository) }
    let(:user) { create(:user) }

    it 'GitHubから対象の Issue を取得する(処理を呼び出す)こと' do
      synchronizer.call({ repository:, user: })
      expect(GitHub::Issue).to have_received(:created_by)
    end

    it '取得したデータをデータベースへ同期させる(処理を呼び出す)こと' do
      synchronizer.call({ repository:, user: })
      expect(Issue).to have_received(:synchronize)
    end
  end
end
