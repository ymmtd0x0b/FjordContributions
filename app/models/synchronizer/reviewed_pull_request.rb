# frozen_string_literal: true

module Synchronizer
  class ReviewedPullRequest
    def call(payload)
      repository = payload[:repository]
      user = payload[:user]

      pull_requests = GitHub::PullRequest.reviewed_by(repository, user)
      PullRequest.synchronize(pull_requests)
      Review.synchronize(pull_requests, user)
    end
  end
end
