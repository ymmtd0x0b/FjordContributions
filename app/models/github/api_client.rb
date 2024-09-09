# frozen_string_literal: true

module GitHub
  class APIClient
    include ActiveSupport::Configurable
    config_accessor :github_access_token, instance_reader: true, instance_writer: false

    def initialize
      @client = Octokit::Client.new(access_token: github_access_token)
    end

    def repository(id: nil, name: nil)
      id ? @client.repo(id.to_i) : @client.repo(name)
    rescue Octokit::Error => e
      log_error(e)
      nil
    end

    def labels(repository_name, option = { page: 1, per_page: 100 })
      labels = []
      loop do
        labels_per_page = @client.labels(repository_name, option)
        labels.concat labels_per_page
        option[:page] += 1
        break unless labels_per_page.count == option[:per_page]
      end

      labels
    rescue Octokit::Error => e
      log_error(e)
      []
    end

    def user(id_or_login)
      @client.user id_or_login
    rescue Octokit::Error => e
      log_error(e)
      nil
    end

    def search_issues(query, option = { page: 1, per_page: 100 })
      issues = []
      loop do
        issues_per_page = @client.search_issues(query, option)
        issues.concat issues_per_page.items
        option[:page] += 1
        break unless issues_per_page.items.count == option[:per_page]
      end

      issues
    rescue Octokit::Error => e
      log_error(e)
      []
    end

    private

    def log_error(exception)
      # NOTE: exception の例
      #       - GET https://api.github.com/repos/test/error: 404 - Not Found // See: https://docs.github.com/rest/repos/repos#get-a-repository
      Rails.logger.error "[GitHub API] #{exception.message}"
    end
  end
end
