# frozen_string_literal: true

module GitHub
  class Issue
    attr_reader :id, :number, :labels_id

    def initialize(repository_id:, issue: { id:, user_id:, title:, number:, labels_id:, created_at:, updated_at: })
      @id = issue[:id]
      @repository_id = repository_id
      @author_id = issue[:user_id]
      @title = issue[:title]
      @number = issue[:number]
      @labels_id = issue[:labels_id]
      @created_at = issue[:created_at]
      @updated_at = issue[:updated_at]
    end

    def to_h
      { id: @id,
        repository_id: @repository_id,
        author_id: @author_id,
        title: @title,
        number: @number,
        created_at: @created_at,
        updated_at: @updated_at }
    end

    def create_labelings
      @labels_id.map { |label_id| { issue_id: @id, label_id: } }
    end

    class << self
      def created_by(repository, user)
        client = GitHub::APIClient.new
        issues = client.search_issues("repo:#{repository.name} is:issue author:#{user.login}")
        issues.map { |issue| new(repository_id: repository.id, issue: convert_to_hash(issue)) }
      end

      private

      def convert_to_hash(issue)
        { id: issue.id,
          user_id: issue.user.id,
          title: issue.title,
          number: issue.number,
          labels_id: issue.labels.map(&:id),
          created_at: issue.created_at,
          updated_at: issue.updated_at }
      end
    end
  end
end
