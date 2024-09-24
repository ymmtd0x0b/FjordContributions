Rails.configuration.to_prepare do
  Git::Wiki.configure do |config|
    config.github_url = ENV['GITHUB_URL']
  end
end
