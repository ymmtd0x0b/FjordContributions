# frozen_string_literal: true

module Synchronizer
  class CreatedIssue
    def call(payload)
      repository = payload[:repository]
      user = payload[:user]

      issues = GitHub::Issue.created_by(repository, user)
      Issue.synchronize(issues)
    end
  end
end
