# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GitHub::Issue, type: :model do
  describe '#to_h' do
    it '自身をハッシュ(連想配列)へ変換して返すこと( labels_id は含まない )' do
      issue = GitHub::Issue.new(repository_id: 123, issue: { id: 111, user_id: 222, title: 'bug', number: 333, labels_id: [444],
                                                             created_at: '2000/10/10 09:00:00', updated_at: '2000/10/10 10:00:00' })
      expect(issue.to_h).to eq({ repository_id: 123, id: 111, author_id: 222, title: 'bug', number: 333,
                                 created_at: '2000/10/10 09:00:00', updated_at: '2000/10/10 10:00:00' })
    end
  end

  describe '#create_labelings' do
    it 'Issue と Label の ID をハッシュとして要素に持つ Array で返すこと' do
      issue = GitHub::Issue.new(repository_id: 123, issue: { id: 111, user_id: 222, title: 'bug', number: 333, labels_id: [444, 555],
                                                             created_at: '2000/10/10 09:00:00', updated_at: '2000/10/10 10:00:00' })

      expect(issue.create_labelings).to eq([{ issue_id: 111, label_id: 444 },
                                            { issue_id: 111, label_id: 555 }])
    end
  end

  describe '.created_by' do
    context '該当する Issue がある場合' do
      it ' GitHub::Issue オブジェクトを要素に持つ Array を返すこと', vcr: { cassette_name: 'github/issue/created_by' } do
        repository = create(:repository, name: 'test/repository')
        user = create(:user, login: 'kimura')

        issues = GitHub::Issue.created_by(repository, user)
        expect(issues).not_to be_empty
        expect(issues).to all(be_instance_of(GitHub::Issue))
      end
    end

    context '該当する Issue がない場合' do
      it '空の Array を返すこと', vcr: { cassette_name: 'github/issue/created_by_with_not_found' } do
        repository = create(:repository, name: 'test/repository')
        user = create(:user, login: 'not_found')

        issues = GitHub::Issue.created_by(repository, user)
        expect(issues).to be_empty
      end
    end
  end

  describe '.assigned_by' do
    context '該当する Issue がある場合' do
      it ' GitHub::Issue オブジェクトを要素に持つ Array を返すこと', vcr: { cassette_name: 'github/issue/assigned_by' } do
        repository = create(:repository, name: 'test/repository')
        user = create(:user, login: 'kimura')

        issues = GitHub::Issue.assigned_by(repository, user)
        expect(issues).not_to be_empty
        expect(issues).to all(be_instance_of(GitHub::Issue))
      end
    end

    context '該当する Issue がない場合' do
      it '空の Array を返すこと', vcr: { cassette_name: 'github/issue/assigned_by_with_not_found' } do
        repository = create(:repository, name: 'test/repository')
        user = create(:user, login: 'not_found')

        issues = GitHub::Issue.assigned_by(repository, user)
        expect(issues).to be_empty
      end
    end
  end

  describe '.reviewed_by' do
    context '該当する Issue がある場合' do
      it ' GitHub::Issue オブジェクトを要素に持つ Array を返すこと', vcr: { cassette_name: 'github/issue/reviewed_by' } do
        repository = create(:repository, name: 'test/repository')
        user = create(:user, login: 'kimura')

        issues = GitHub::Issue.reviewed_by(repository, user)
        expect(issues).not_to be_empty
        expect(issues).to all(be_instance_of(GitHub::Issue))
      end
    end

    context '該当する Issue がない場合' do
      it '空の Array を返すこと', vcr: { cassette_name: 'github/issue/reviewed_by_with_not_found' } do
        repository = create(:repository, name: 'test/repository')
        user = create(:user, login: 'not_found')

        issues = GitHub::Issue.reviewed_by(repository, user)
        expect(issues).to be_empty
      end
    end
  end
end
