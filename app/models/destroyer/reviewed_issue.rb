# frozen_string_literal: true

module Destroyer
  class ReviewedIssue
    def call(user)
      user.reviewed_issues.not_referenced_by_other_users.destroy_all
    end
  end
end
