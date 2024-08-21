# frozen_string_literal: true

module GitHub
  class APIClient
    def initialize
      @client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
    end

    def repository(id: nil, name: nil)
      id ? @client.repo(id.to_i) : @client.repo(name)
    rescue Octokit::Error => e
      log_error(e)
      nil
    end

    private

    def log_error(exception)
      # NOTE: exception の例
      #       - GET https://api.github.com/repos/test/error: 404 - Not Found // See: https://docs.github.com/rest/repos/repos#get-a-repository
      Rails.logger.error "[GitHub API] #{exception.message}"
    end
  end
end
