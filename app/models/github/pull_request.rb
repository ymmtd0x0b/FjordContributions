# frozen_string_literal: true

module GitHub
  class PullRequest
    attr_reader :id, :issues_number

    def initialize(repository_id:, pull_request: { id:, number:, issues_number:, created_at:, updated_at: })
      @id = pull_request[:id]
      @repository_id = repository_id
      @number = pull_request[:number]
      @issues_number = pull_request[:issues_number]
      @created_at = pull_request[:created_at]
      @updated_at = pull_request[:updated_at]
    end

    def to_h
      { id: @id,
        repository_id: @repository_id,
        number: @number,
        created_at: @created_at,
        updated_at: @updated_at }
    end

    def resolutions
      ::Issue.where(number: @issues_number).pluck(:id).map { |issue_id| { issue_id:, pull_request_id: @id } }
    end

    class << self
      def assigned_by(repository, user)
        client = GitHub::APIClient.new
        pull_requests = client.search_issues("repo:#{repository.name} is:pr assignee:#{user.login} -label:release")
        pull_requests.map { |pull_request| new(repository_id: repository.id, pull_request: convert_to_hash(pull_request)) }
      end

      def reviewed_by(repository, user)
        client = GitHub::APIClient.new
        pull_requests = client.search_issues("repo:#{repository.name} is:pr reviewed-by:#{user.login} review:approved -assignee:#{user.login}")
        pull_requests.map { |pull_request| GitHub::PullRequest.new(repository_id: repository.id, pull_request: convert_to_hash(pull_request)) }
      end

      private

      def convert_to_hash(pull_request)
        { id: pull_request.id,
          number: pull_request.number,
          issues_number: scan_issues_number(pull_request.body),
          created_at: pull_request.created_at,
          updated_at: pull_request.updated_at }
      end

      def scan_issues_number(body)
        issue_section = body.slice(/# [Ii]ssue.+# 概要/m)
        return [] if issue_section.blank?

        issue_urls = issue_section.scan(%r{http.+/issues/\d+|#\d+})
        issue_urls.map { |issue_url| issue_url.slice(/\d+$/).to_i }.uniq
      end
    end
  end
end
