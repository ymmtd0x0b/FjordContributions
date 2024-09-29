# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GitHub::User, type: :model do
  describe '#to_h' do
    it '自身をハッシュ(連想配列)へ変換して返すこと' do
      user = GitHub::User.new(id: 123, login: 'kimura', name: 'キムラ', avatar_url: 'http://example.com/avatar.png')
      expect(user.to_h).to eq({ id: 123, login: 'kimura', name: 'キムラ', avatar_url: 'http://example.com/avatar.png' })
    end
  end

  describe '.find_by' do
    context 'ユーザーが見つかった場合' do
      it 'GitHub::User オブジェクトを返すこと', vcr: { cassette_name: 'github/user/find_by' } do
        user = GitHub::User.find_by(login: 'kimura')
        expect(user).to be_instance_of(GitHub::User)
      end
    end

    context 'ユーザーが見つからない場合' do
      it 'エラーを返すこと', vcr: { cassette_name: 'github/user/find_by_with_not_found' } do
        expect { GitHub::User.find_by(login: 'not_found_user') }.to raise_error(Octokit::Error)
      end
    end
  end
end
