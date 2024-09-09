# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it '有効なファクトリを持つこと' do
    user = build(:user)
    expect(user).to be_valid
  end

  describe '.find_or_initialize_by_github_auth' do
    let(:auth_hash) { OmniAuth::AuthHash.new(uid: 123, info: { nickname: 'taro', name: 'タロウ', image: 'https://example.com/avatar.png' }) }

    context 'ユーザーが未登録の場合' do
      it '新規インスタンスとして返すこと' do
        user = User.find_or_initialize_by_github_auth(auth_hash)
        expect(user.new_record?).to be_truthy
        expect(user.attributes).to eq({ 'id' => 123, 'login' => 'taro', 'name' => 'タロウ', 'avatar_url' => 'https://example.com/avatar.png',
                                        'created_at' => nil, 'updated_at' => nil })
      end
    end

    context 'ユーザーが登録済みの場合' do
      it 'インスタンスを返すこと' do
        create(:user, id: 123)
        user = User.find_or_initialize_by_github_auth(auth_hash)
        expect(user.persisted?).to be_truthy
      end
    end
  end
end
