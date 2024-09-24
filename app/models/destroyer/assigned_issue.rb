# frozen_string_literal: true

module Destroyer
  class AssignedIssue
    def call(user)
      user.assigned_issues.not_referenced_by_other_users.destroy_all
    end
  end
end
