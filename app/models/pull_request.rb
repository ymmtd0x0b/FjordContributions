# frozen_string_literal: true

class PullRequest < ApplicationRecord
  belongs_to :repository

  has_many :assigns, as: :assignable, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many :resolutions, dependent: :destroy
  has_many :issues, through: :resolutions, source: :issue
end
