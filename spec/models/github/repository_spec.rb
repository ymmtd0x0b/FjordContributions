# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GitHub::Repository, type: :model do
  describe '#to_h' do
    it 'id, name, avatar_url をキーに持つハッシュ(連想配列)を返すこと' do
      repository = GitHub::Repository.new(id: 123,
                                          name: 'test_repository',
                                          avatar_url: 'https://example.com/test_repository/avatar.jpg',
                                          created_at: '2000-01-01 09:00:00 +0000',
                                          updated_at: '2000-01-01 10:00:00 +0000')

      expect(repository.to_h).to eq({ id: 123,
                                      name: 'test_repository',
                                      avatar_url: 'https://example.com/test_repository/avatar.jpg',
                                      created_at: '2000-01-01 09:00:00 +0000',
                                      updated_at: '2000-01-01 10:00:00 +0000' })
    end
  end

  describe '.find_by' do
    context 'リポジトリが見つかった場合' do
      it 'GitHub::Resitoryオブジェクトのインスタンスを返すこと', vcr: { cassette_name: 'github/api_client/repository' } do
        actual = GitHub::Repository.find_by(name: 'test/repository')
        expect(actual).to be_an_instance_of(GitHub::Repository)
      end
    end

    context 'リポジトリが見つからない場合' do
      it 'nilを返すこと', vcr: { cassette_name: 'github/api_client/repository_with_not_found' } do
        actual = GitHub::Repository.find_by(name: 'test/non_exist_repository')
        expect(actual).to eq nil
      end
    end
  end
end
