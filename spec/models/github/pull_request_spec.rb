# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GitHub::PullRequest, type: :model do
  describe '#to_h' do
    it '自身をハッシュ(連想配列)へ変換して返すこと( issues_number は含まない )' do
      pull_request_data = { id: 111, number: 222, issues_number: [333, 444], created_at: '2000/01/01 09:00:00', updated_at: '2000/01/01 10:00:00' }
      pull_request = GitHub::PullRequest.new(repository_id: 123, pull_request: pull_request_data)

      expect(pull_request.to_h).to eq({ repository_id: 123, id: 111, number: 222, created_at: '2000/01/01 09:00:00', updated_at: '2000/01/01 10:00:00' })
    end
  end

  describe '.assigned_by' do
    context '該当する PullRequest がある場合' do
      it 'GitHub::PullRequest オブジェクトを要素に持つ Array を返すこと', vcr: { cassette_name: 'github/pull_request/assigned_by' } do
        repository = create(:repository, name: 'test/repository')
        user = create(:user, login: 'kimura')

        pull_requests = GitHub::PullRequest.assigned_by(repository, user)
        expect(pull_requests).not_to be_empty
        expect(pull_requests).to all(be_instance_of(GitHub::PullRequest))
      end
    end

    context '該当する PullRequest がない場合' do
      it '空の Array を返すこと', vcr: { cassette_name: 'github/pull_request/assigned_by_with_not_found' } do
        repository = create(:repository, name: 'test/repository')
        user = create(:user, login: 'not_found')

        pull_requests = GitHub::PullRequest.assigned_by(repository, user)
        expect(pull_requests).to be_empty
      end
    end
  end
end
