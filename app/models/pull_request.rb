# frozen_string_literal: true

class PullRequest < ApplicationRecord
  belongs_to :repository
end
