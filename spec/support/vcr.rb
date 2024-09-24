# frozen_string_literal: true

require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr'
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
  config.configure_rspec_metadata!
  config.filter_sensitive_data('<GITHUB_ACCESS_TOKEN>') { ENV.fetch('GITHUB_ACCESS_TOKEN', nil) }

  config.ignore_request do |request| # テスト環境下でのみ発生するリクエストは記録しない
    ['127.0.0.1', 'googlechromelabs.github.io'].include?(URI(request.uri).host)
  end
end
