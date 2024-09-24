# frozen_string_literal: true

module WikiDecorator
  def url
    base_url = ENV['GITHUB_URL']
    "#{base_url}/#{repository.name}/wiki/#{title}"
  end
end
