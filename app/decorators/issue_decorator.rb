# frozen_string_literal: true

module IssueDecorator
  def point
    labels.pluck(:name).sum(&:to_i)
  end

  def url
    base_url = ENV['GITHUB_URL']
    "#{base_url}/#{repository.name}/issues/#{number}"
  end
end
