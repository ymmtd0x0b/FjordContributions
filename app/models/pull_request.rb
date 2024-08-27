# frozen_string_literal: true

class PullRequest < ApplicationRecord
  belongs_to :repository

  has_many :assigns, as: :assignable, dependent: :destroy
  has_many :assignees, through: :assigns, source: :user

  has_many :reviews, dependent: :destroy
  has_many :reviewers, through: :reviews, source: :user

  has_many :resolutions, dependent: :destroy
  has_many :issues, through: :resolutions, source: :issue

  def assignee?(user)
    assignees.include?(user)
  end

  def reviewer?(user)
    reviewers.include?(user)
  end
end
