# frozen_string_literal: true

class Labeling < ApplicationRecord
  belongs_to :issue
  belongs_to :label

  class << self
    def synchronize(issues_by_github_api)
      issues_id = issues_by_github_api.map(&:id)
      labels_id = issues_by_github_api.flat_map(&:labels_id)
      where(issue_id: issues_id).where.not(label_id: labels_id).delete_all

      hash_list = issues_by_github_api.flat_map(&:create_labelings)
      upsert_all(hash_list, unique_by: %i[issue_id label_id]) if hash_list.any?
    end
  end
end
