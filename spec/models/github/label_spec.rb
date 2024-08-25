# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Label, type: :model do
  describe '#to_h' do
    it '自身をハッシュ(連想配列)へ変換して返すこと' do
      label = GitHub::Label.new(repository_id: 123, label: { id: 222, name: 'bug', color: 'ffffff' })
      expect(label.to_h).to eq({ repository_id: 123, id: 222, name: 'bug', color: 'ffffff' })
    end
  end

  describe '.registered_by' do
    let(:repository) { create(:repository, name: 'test/repository') }

    context 'リポジトリに登録されたラベルがある場合' do
      it 'GitHub::Label オブジェクトを要素に持つ Array を返すこと', vcr: { cassette_name: 'github/label/registred_by' } do
        labels = GitHub::Label.registered_by(repository)
        expect(labels).not_to be_empty
        expect(labels).to all(be_instance_of(GitHub::Label))
      end
    end

    context 'リポジトリに登録されたラベルがない場合' do
      it '空の Array を返すこと', vcr: { cassette_name: 'github/label/registred_by_with_not_found' } do
        labels = GitHub::Label.registered_by(repository)
        expect(labels).to be_empty
      end
    end
  end
end
