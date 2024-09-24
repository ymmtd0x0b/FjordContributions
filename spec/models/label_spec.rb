# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Label, type: :model do
  it '有効なファクトリを持つこと' do
    label = build(:label, :with_repository)
    expect(label).to be_valid
  end

  describe '.synchronize' do
    let!(:repository) { create(:repository, id: 123) }

    context '引数に渡されたデータの中に「未登録のラベル」がある場合' do
      it '新たに登録すること' do
        create(:label, repository_id: 123, id: 100, name: 'bug')

        issues_collected_by_the_github_api = [
          GitHub::Label.new(repository_id: 123, label: { id: 100, name: 'bug', color: '' }),
          GitHub::Label.new(repository_id: 123, label: { id: 200, name: 'fix', color: '' })
        ]

        expect do
          Label.synchronize(repository, issues_collected_by_the_github_api)
        end.to change(Label, :count).from(1).to(2)
      end
    end

    context '引数に渡されたデータの中に「登録済みのラベル 」がある場合' do
      it '該当ラベルの情報を更新すること' do
        label = create(:label, repository_id: 123, id: 100, name: 'bug')

        labels_collected_by_the_github_api = [
          GitHub::Label.new(repository_id: 123, label: { id: 100, name: 'バグ', color: '' })
        ]

        expect do
          Label.synchronize(repository, labels_collected_by_the_github_api)
        end.to change { label.reload.name }.from('bug').to('バグ')
      end
    end

    context '引数に渡されたデータの中に「登録済みのラベル」がない場合' do
      it '該当ラベルを削除すること' do
        create(:label, repository_id: 123, id: 100, name: 'bug')
        create(:label, repository_id: 123, id: 200, name: 'remove')

        labels_collected_by_the_github_api = [
          GitHub::Label.new(repository_id: 123, label: { id: 100, name: 'bug', color: '' })
        ]

        expect do
          Label.synchronize(repository, labels_collected_by_the_github_api)
        end.to change { Label.pluck(:name) }.from(%w[bug remove]).to(['bug'])
      end
    end
  end
end
