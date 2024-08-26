# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Git::Wiki, type: :model do
  describe '#to_h' do
    it '自身をハッシュ(連想配列)へ変換して返すこと' do
      wiki = Git::Wiki.new(repository_id: 123, file_data: { user_id: 111,
                                                            title: '議事録',
                                                            first_commit_hash: 'aaabbb',
                                                            created_at: '2024-03-03',
                                                            updated_at: '2024-04-04' })

      expect(wiki.to_h).to eq({ repository_id: 123,
                                author_id: 111,
                                title: '議事録',
                                first_commit_hash: 'aaabbb',
                                created_at: '2024-03-03',
                                updated_at: '2024-04-04' })
    end
  end

  describe '.created_by' do
    before do
      @tmpdir_realpath = create_dummy_repository_wiki
      allow(Git::Wiki).to receive(:github_url).and_return(@tmpdir_realpath)
    end

    def create_dummy_repository_wiki
      tmpdir = Dir.mktmpdir
      tmpdir_realpath = File.realpath tmpdir

      Dir.chdir(tmpdir_realpath) do
        git = Git.init('test/repository.wiki.git')
        git.config('user.name', 'kimura')
        git.config('user.email', 'kimura@email.com')

        File.write('test/repository.wiki.git/test.txt', 'test')
        git.add('test.txt')
        git.commit('first commit')
      end

      tmpdir_realpath
    end

    after do
      FileUtils.remove_entry_secure @tmpdir_realpath
    end

    context '該当する Wiki がある場合' do
      it 'Git::Wiki オブジェクトを要素に持つ Array を返すこと' do
        repository = create(:repository, name: 'test/repository')
        user = create(:user, login: 'kimura')

        wikis = Git::Wiki.created_by(repository, user)
        expect(wikis).not_to be_empty
        expect(wikis).to all(be_instance_of(Git::Wiki))
      end
    end

    context '該当する Wiki がない場合' do
      it '空の Array を返すこと' do
        repository = create(:repository, name: 'test/repository')
        user = create(:user, login: 'hajime')

        wikis = Git::Wiki.created_by(repository, user)
        expect(wikis).to be_empty
      end
    end

    context 'エラーが発生した場合' do
      before do
        @repository = create(:repository, name: 'not_found_repository')
        @user = create(:user, login: 'kimura')
      end

      it '空の Array を返すこと' do
        wikis = Git::Wiki.created_by(@repository, @user)
        expect(wikis).to be_empty
      end

      it 'ログに出力すること' do
        expect(Rails.logger).to receive(:error)
        Git::Wiki.created_by(@repository, @user)
      end
    end
  end
end
