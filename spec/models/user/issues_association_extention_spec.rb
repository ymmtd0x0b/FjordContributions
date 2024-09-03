# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::IssuesAssociationExtension do
  describe '#not_referenced_by_other_users' do
    context 'ユーザーが作成者である Issue の内 (has_many :issues)' do
      let(:repository) { create(:repository, id: 123) }
      let(:taro) { create(:user, id: 456, login: 'taro') }
      let(:jiro) { create(:user, id: 789, login: 'jiro') }

      it '他のユーザーが作成者でない Issue を返すこと' do
        create(:issue, repository:, id: 100, author: taro)
        create(:issue, repository:, id: 200, author: jiro)

        actual = taro.issues.not_referenced_by_other_users.ids
        expect(actual).to eq [100]
      end
    end
  end
end
