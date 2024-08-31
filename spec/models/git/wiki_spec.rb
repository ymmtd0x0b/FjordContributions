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
    context '該当する Wiki がある場合' do
      it 'Git::Wiki オブジェクトを要素に持つ Array を返すこと' do
        DummyRepositoryWiki.init('test/repository', author: 'kimura') do |tmpdir_realpath|
          allow(Git::Wiki).to receive(:github_url).and_return(tmpdir_realpath)

          repository = create(:repository, name: 'test/repository')
          kimura = create(:user, login: 'kimura')

          wikis = Git::Wiki.created_by(repository, kimura)
          expect(wikis).not_to be_empty
          expect(wikis).to all(be_instance_of(Git::Wiki))
        end
      end
    end

    context '該当する Wiki がない場合' do
      it '空の Array を返すこと' do
        DummyRepositoryWiki.init('test/repository', author: 'kimura') do |tmpdir_realpath|
          allow(Git::Wiki).to receive(:github_url).and_return(tmpdir_realpath)

          repository = create(:repository, name: 'test/repository')
          hajime = create(:user, login: 'hajime')

          wikis = Git::Wiki.created_by(repository, hajime)
          expect(wikis).to be_empty
        end
      end
    end

    context 'エラーが発生した場合' do
      before do
        allow(Rails.logger).to receive(:error)
        allow(Git).to receive(:clone) do
          result = Git::CommandLineResult.new(%w[git status], `exit 1`, '', 'error!!')
          error = Git::CommandLineError.new(result)
          raise(error)
        end
      end

      let(:repository) { create(:repository) }
      let(:user) { create(:user) }

      it '空の Array を返すこと' do
        wikis = Git::Wiki.created_by(repository, user)
        expect(wikis).to be_empty
      end

      it 'ログに出力すること' do
        Git::Wiki.created_by(repository, user)
        expect(Rails.logger).to have_received(:error).with('[Git] error!!')
      end
    end
  end
end
