#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails tailwindcss:build
bundle exec rails assets:clean
bundle exec rake db:migrate
