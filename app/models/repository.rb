# frozen_string_literal: true

class Repository < ApplicationRecord
  has_many :labels, dependent: :destroy
end
