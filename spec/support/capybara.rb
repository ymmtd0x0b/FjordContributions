# frozen_string_literal: true

RSpec.configure do |config|
  if ENV['HEADFULL']
    config.before(:each, type: :system) { driven_by :selenium_chrome }
  else
    config.before(:each, type: :system) { driven_by :selenium_chrome_headless }
  end
end
