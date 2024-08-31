# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Synchronizer::CreatedWiki, type: :model do
  describe '#call' do
    before do
      allow(Git::Wiki).to receive(:created_by)
      allow(Wiki).to receive(:synchronize)
    end

    let(:synchronizer) { Synchronizer::CreatedWiki.new }
    let(:repository) { create(:repository) }
    let(:user) { create(:user) }

    it 'GitHub から Wiki のデータを取得する(処理を呼び出す)こと' do
      synchronizer.call({ repository:, user: })
      expect(Git::Wiki).to have_received(:created_by)
    end

    it '取得したデータをデータベースへ同期させる(処理を呼び出す)こと' do
      synchronizer.call({ repository:, user: })
      expect(Wiki).to have_received(:synchronize)
    end
  end
end
