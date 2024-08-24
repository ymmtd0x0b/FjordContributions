# frozen_string_literal: true

class Issue < ApplicationRecord
  belongs_to :author, class_name: 'User', optional: true
  belongs_to :repository

  has_many :assigns, as: :assignable, dependent: :destroy
  has_many :assignees, through: :assigns, source: :user
end
