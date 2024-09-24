# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Labeling, type: :model do
  describe '.synchronize' do
    before do
      create(:repository, id: 123) do |repository|
        create(:label, repository:, id: 10)
        create(:label, repository:, id: 20)
      end
    end

    context '引数に渡された Issue の labels_id に、既存のアソシエーションに該当しないラベル情報が存在する場合' do
      it '対象ラベルと Issue のアソシエーションを登録する' do
        issue = create(:issue, :with_author, repository_id: 123, id: 100)
        issue.labelings.create!(label_id: 10)

        issues_collected_by_the_github_api = [GitHub::Issue.new(repository_id: 123, issue: { id: 100, labels_id: [10, 20] })]

        expect { Labeling.synchronize(issues_collected_by_the_github_api) }.to change { issue.labels.ids }.from([10]).to([10, 20])
      end
    end

    context '引数に渡された Issue の labels_id に、既存のアソシエーションのラベル情報が存在しない場合' do
      it '対象のアソシエーションを削除する' do
        issue = create(:issue, :with_author, repository_id: 123, id: 100)
        issue.labelings.create!(label_id: 10)
        issue.labelings.create!(label_id: 20)

        issues_collected_by_the_github_api = [GitHub::Issue.new(repository_id: 123, issue: { id: 100, labels_id: [10] })]

        expect { Labeling.synchronize(issues_collected_by_the_github_api) }.to change { issue.labels.ids }.from([10, 20]).to([10])
      end
    end
  end
end
