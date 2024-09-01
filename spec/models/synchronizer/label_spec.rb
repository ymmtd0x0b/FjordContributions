# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Synchronizer::Label, type: :model do
  describe '#call' do
    before do
      allow(GitHub::Label).to receive(:registered_by)
      allow(Label).to receive(:synchronize)
    end

    let(:synchronizer) { Synchronizer::Label.new }
    let(:repository) { create(:repository) }
    let(:user) { create(:user) }

    it 'GitHub から Label のデータを取得する(処理を呼び出す)こと' do
      synchronizer.call({ repository:, user: })
      expect(GitHub::Label).to have_received(:registered_by)
    end

    it '取得したデータをデータベースへ同期させる(処理を呼び出す)こと' do
      synchronizer.call({ repository:, user: })
      expect(Label).to have_received(:synchronize)
    end
  end
end
