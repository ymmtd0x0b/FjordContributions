# frozen_string_literal: true

module IssueDecorator
  def point
    labels.pluck(:name).sum(&:to_i)
  end
end
