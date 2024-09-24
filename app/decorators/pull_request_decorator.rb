# frozen_string_literal: true

module PullRequestDecorator
  def url
    base_url = ENV['GITHUB_URL']
    "#{base_url}/#{repository.name}/pull/#{number}"
  end
end
