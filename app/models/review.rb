# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :pull_request
  belongs_to :user
end
