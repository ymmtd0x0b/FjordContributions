# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wiki, type: :model do
  it '有効なファクトリを持つこと' do
    wiki = build(:wiki, :with_repository, :with_author)
    expect(wiki).to be_valid
  end

  describe '.synchronize' do
    before do
      create(:repository, id: 123)
      create(:user, id: 456)
    end

    context '引数に渡されたデータの中に「未登録の Wiki」がある場合' do
      it '新たに登録すること' do
        create(:wiki, repository_id: 123, author_id: 456, title: 'Wiki#1', first_commit_hash: 'aaa')

        wikis_collected_by_the_github_api = [
          Git::Wiki.new(repository_id: 123, file_data: { user_id: 456, title: 'Wiki#1', first_commit_hash: 'aaa',
                                                         created_at: '2000/01/01 09:00:00', updated_at: '2000/01/01 10:00:00' }),
          Git::Wiki.new(repository_id: 123, file_data: { user_id: 456, title: 'Wiki#2', first_commit_hash: 'bbb',
                                                         created_at: '2000/01/01 09:00:00', updated_at: '2000/01/01 10:00:00' })
        ]

        expect do
          user = User.find(456)
          Wiki.synchronize(wikis_collected_by_the_github_api, user)
        end.to change { Wiki.count }.from(1).to(2)
      end
    end

    context '引数に渡されたデータの中に「登録済みの Wiki」がある場合' do
      it '該当 Wiki の情報を更新すること' do
        wiki = create(:wiki, repository_id: 123, author_id: 456, title: 'before update...', first_commit_hash: 'aaa')

        wikis_collected_by_the_github_api = [
          Git::Wiki.new(repository_id: 123, file_data: { user_id: 456, title: 'updated!', first_commit_hash: 'aaa',
                                                         created_at: '2000/01/01 09:00:00', updated_at: '2000/01/01 10:00:00' })
        ]

        expect do
          user = User.find(456)
          Wiki.synchronize(wikis_collected_by_the_github_api, user)
        end.to change { wiki.reload.title }.from('before update...').to('updated!')
      end
    end

    context '登録済みの Wiki が引数に渡されたデータの中に存在しない場合' do
      it '該当 Wiki のデータを削除すること' do
        create(:wiki, repository_id: 123, author_id: 456, title: 'Wiki#100', first_commit_hash: 'aaa')
        create(:wiki, repository_id: 123, author_id: 456, title: 'Wiki#200', first_commit_hash: 'bbb')

        wikis_collected_by_the_github_api = [
          Git::Wiki.new(repository_id: 123, file_data: { user_id: 456, title: 'Wiki#100', first_commit_hash: 'aaa',
                                                         created_at: '2000/01/01 09:00:00', updated_at: '2000/01/01 10:00:00' })
        ]

        expect do
          user = User.find(456)
          Wiki.synchronize(wikis_collected_by_the_github_api, user)
        end.to change { Wiki.count }.from(2).to(1)
      end
    end
  end
end
