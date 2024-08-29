# frozen_string_literal: true

module Synchronizer
  class AssignedIssue
    def call(payload)
      repository = payload[:repository]
      user = payload[:user]

      issues = GitHub::Issue.assigned_by(repository, user)
      Issue.synchronize(issues)
      Assign.synchronize('Issue', issues, user)
    end
  end
end
