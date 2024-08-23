# frozen_string_literal: true

class Repository < ApplicationRecord
  has_many :labels, dependent: :destroy
  has_many :issues, dependent: :destroy
end
