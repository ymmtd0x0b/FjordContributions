# frozen_string_literal: true

module Synchronizer
  class AssignedPullRequest
    def call(payload)
      repository = payload[:repository]
      user = payload[:user]

      pull_requests = GitHub::PullRequest.assigned_by(repository, user)
      PullRequest.synchronize(pull_requests)
      Assign.synchronize('PullRequest', pull_requests, user)
    end
  end
end
