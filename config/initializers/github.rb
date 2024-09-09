Rails.configuration.to_prepare do
  GitHub::APIClient.configure do |config|
    config.github_access_token = ENV['GITHUB_ACCESS_TOKEN']
  end
end
