# frozen_string_literal: true

module Destroyer
  class CreatedIssue
    def call(user)
      user.issues.not_referenced_by_other_users.destroy_all
    end
  end
end
