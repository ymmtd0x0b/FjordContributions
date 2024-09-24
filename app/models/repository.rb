# frozen_string_literal: true

class Repository < ApplicationRecord
  validates :name, presence: true

  has_many :labels, dependent: :destroy
  has_many :issues, dependent: :destroy
  has_many :pull_requests, dependent: :destroy
  has_many :wikis, dependent: :destroy
end
