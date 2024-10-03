# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :pull_request
  belongs_to :user

  class << self
    def synchronize(pull_requests_by_github_api, user)
      pull_requests_id = pull_requests_by_github_api.map(&:id)
      user.reviews.where.not(pull_request_id: pull_requests_id).destroy_all

      hash_list = pull_requests_by_github_api.map { |pull_request| { pull_request_id: pull_request.id, user_id: user.id } }
      insert_all(hash_list, unique_by: %i[user_id pull_request_id]) if hash_list.any?
    end
  end
end
