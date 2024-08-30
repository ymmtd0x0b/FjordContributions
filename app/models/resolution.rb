# frozen_string_literal: true

class Resolution < ApplicationRecord
  belongs_to :issue
  belongs_to :pull_request

  class << self
    def synchronize(pull_requests_by_github_api)
      pull_requests_id = pull_requests_by_github_api.map(&:id)
      issues_number = pull_requests_by_github_api.flat_map(&:issues_number)
      issues_id = Issue.where(number: issues_number).ids

      where(pull_request_id: pull_requests_id).where.not(issue_id: issues_id).delete_all

      hash_list = pull_requests_by_github_api.flat_map(&:resolutions)
      insert_all(hash_list, unique_by: %i[issue_id pull_request_id]) if hash_list.any?
    end
  end
end
