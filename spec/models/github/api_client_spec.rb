# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GitHub::APIClient, type: :model do
  before do
    @client = GitHub::APIClient.new
    allow(Rails.logger).to receive(:error)
  end

  describe '#repository' do
    context 'リポジトリを見つかった場合' do
      it 'Sawyer::Resourceオブジェクトを返すこと', vcr: { cassette_name: 'github/api_client/repository' } do
        actual = @client.repository(name: 'test/repository')
        expect(actual).to be_instance_of(Sawyer::Resource)
      end
    end

    context 'エラーが発生した場合(リポジトリが見つからない場合もエラーに含む)' do
      it 'nilを返すこと', vcr: { cassette_name: 'github/api_client/repository_with_not_found' } do
        actual = @client.repository(name: 'test/non_exist_repository')
        expect(actual).to eq nil
      end

      it 'ログへ出力すること', vcr: { cassette_name: 'github/api_client/repository_with_not_found' } do
        @client.repository(name: 'test/non_exist_repository')
        expect(Rails.logger).to have_received(:error).with(<<~LOG.chomp
          [GitHub API] GET https://api.github.com/repos/test/non_exist_repository: 404 - Not Found // See: https://docs.github.com/rest/repos/repos#get-a-repository
        LOG
                                                          )
      end
    end
  end
end
