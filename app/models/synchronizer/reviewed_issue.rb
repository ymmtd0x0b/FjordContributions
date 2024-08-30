# frozen_string_literal: true

module Synchronizer
  class ReviewedIssue
    def call(payload)
      repository = payload[:repository]
      user = payload[:user]

      issues = GitHub::Issue.reviewed_by(repository, user)
      Issue.synchronize(issues)
    end
  end
end
