# frozen_string_literal: true

module Destroyer
  class AssignedPullRequest
    def call(user)
      user.assigned_pull_requests.not_referenced_by_other_users.destroy_all
    end
  end
end
