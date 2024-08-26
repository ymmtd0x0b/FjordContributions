# frozen_string_literal: true

class Label < ApplicationRecord
  belongs_to :repository
  has_many :labelings, dependent: :destroy
end
