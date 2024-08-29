# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GitHub::APIClient, type: :model do
  before do
    allow(Rails.logger).to receive(:error)
  end

  let(:client) { GitHub::APIClient.new }

  describe '#repository' do
    context 'リポジトリを見つかった場合' do
      it 'Sawyer::Resourceオブジェクトを返すこと', vcr: { cassette_name: 'github/api_client/repository' } do
        actual = client.repository(name: 'test/repository')
        expect(actual).to be_instance_of(Sawyer::Resource)
      end
    end

    context 'エラーが発生した場合(リポジトリが見つからない場合もエラーに含む)' do
      it 'nilを返すこと', vcr: { cassette_name: 'github/api_client/repository_with_not_found' } do
        actual = client.repository(name: 'test/non_exist_repository')
        expect(actual).to eq nil
      end

      it 'ログへ出力すること', vcr: { cassette_name: 'github/api_client/repository_with_not_found' } do
        client.repository(name: 'test/non_exist_repository')
        expect(Rails.logger).to have_received(:error).with(<<~LOG.chomp)
          [GitHub API] GET https://api.github.com/repos/test/non_exist_repository: 404 - Not Found // See: https://docs.github.com/rest/repos/repos#get-a-repository
        LOG
      end
    end
  end

  describe '#labels' do
    context 'リポジトリに登録されているラベルが１つ以上ある場合' do
      it 'Sawyer::Resourceオブジェクトを要素に持つ Array を返すこと', vcr: { cassette_name: 'github/api_client/labels' } do
        actual = client.labels('test/repository')
        expect(actual).not_to be_empty
        expect(actual).to all(be_instance_of(Sawyer::Resource))
      end
    end

    context 'リポジトリに登録されているラベルが無い場合' do
      it '空の Array を返すこと', vcr: { cassette_name: 'github/api_client/labels_nothing' } do
        actual = client.labels('test/repository')
        expect(actual).to be_empty
      end
    end

    context 'エラーが発生した場合' do
      it '空の Array を返すこと', vcr: { cassette_name: 'github/api_client/labels_error' } do
        actual = client.labels('test/non_exist_repository')
        expect(actual).to be_empty
      end

      it 'ログへ出力すること', vcr: { cassette_name: 'github/api_client/labels_error' } do
        client.labels('test/non_exist_repository')
        expect(Rails.logger).to have_received(:error).with(<<~LOG.chomp)
          [GitHub API] GET https://api.github.com/repos/test/non_exist_repository/labels?page=1&per_page=100: 404 - Not Found // See: https://docs.github.com/rest/issues/labels#list-labels-for-a-repository
        LOG
      end
    end
  end

  describe '#user' do
    context 'ユーザーが見つかった場合' do
      it 'Sawyer::Resourceオブジェクトを返すこと', vcr: { cassette_name: 'github/api_client/user' } do
        actual = client.user('kimura')
        expect(actual).to be_instance_of(Sawyer::Resource)
      end
    end

    context 'エラーが発生した場合(ユーザーが見つからない場合もエラーに含む)' do
      it 'nilを返すこと', vcr: { cassette_name: 'github/api_client/user_with_not_found' } do
        actual = client.user('not_found_user')
        expect(actual).to eq nil
      end

      it 'ログへ出力すること', vcr: { cassette_name: 'github/api_client/user_with_not_found' } do
        client.user('not_found_user')
        expect(Rails.logger).to have_received(:error).with(<<~LOG.chomp)
          [GitHub API] GET https://api.github.com/users/not_found_user: 404 - Not Found // See: https://docs.github.com/rest
        LOG
      end
    end
  end

  describe '#search_issues' do
    context '該当する issue を見つけた場合' do
      it 'Swayer::Resourceオブジェクトで構成された Array を返すこと', vcr: { cassette_name: 'github/api_client/search_issues' } do
        actual = client.search_issues('repo:test/repository is:issue author:kimura')
        expect(actual).to all(be_instance_of(Sawyer::Resource))
      end
    end

    context '該当する issue が見つからない場合' do
      it '空の Array を返すこと', vcr: { cassette_name: 'github/api_client/search_issues_with_not_found' } do
        actual = client.search_issues('repo:test/repository is:issue author:not_found')
        expect(actual).to be_empty
      end
    end

    context 'エラーが発生した場合' do
      it '空の Array を返すこと', vcr: { cassette_name: 'github/api_client/search_issues_with_error' } do
        actual = client.search_issues('repo:test/repository is:issue author:error')
        expect(actual).to be_empty
      end

      it 'ログへ出力すること', vcr: { cassette_name: 'github/api_client/search_issues_with_error' } do
        client.search_issues('repo:test/repository is:issue author:error')
        expect(Rails.logger).to have_received(:error).with(<<~LOG.chomp)
          [GitHub API] GET https://api.github.com/search/issues?page=1&per_page=100&q=repo%3Atest%2Frepository+is%3Aissue+author%3Aerror: 422 - Validation Failed
          Error summary:
            message: The listed users cannot be searched either because the users do not exist or you do not have permission to view the users.
            resource: Search
            field: q
            code: invalid // See: https://docs.github.com/v3/search/
        LOG
      end
    end
  end
end
