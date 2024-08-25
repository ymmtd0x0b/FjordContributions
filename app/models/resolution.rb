# frozen_string_literal: true

class Resolution < ApplicationRecord
  belongs_to :issue
  belongs_to :pull_request
end
