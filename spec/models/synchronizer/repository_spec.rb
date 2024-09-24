# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Synchronizer::Repository, type: :model do
  describe '#call' do
    it 'リポジトリの情報を更新すること' do
      repo = create(:repository, id: 123, name: 'test/before', avatar_url: 'https://example.com/bofore_avatar.png')

      allow(GitHub::Repository).to receive(:find_by).and_return(
        GitHub::Repository.new(id: 123, name: 'test/after', avatar_url: 'https://example.com/after_avatar.png',
                               created_at: '2000/01/01 00:00:00', updated_at: '2000/01/01 00:00:00')
      )

      synchronizer = Synchronizer::Repository.new
      expect { synchronizer.call({ repository: repo }) }.to change { repo.reload.name }.from('test/before').to('test/after')
                                                        .and change { repo.reload.avatar_url }.from('https://example.com/bofore_avatar.png')
                                                                                              .to('https://example.com/after_avatar.png')
    end
  end
end
