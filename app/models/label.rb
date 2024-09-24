# frozen_string_literal: true

class Label < ApplicationRecord
  belongs_to :repository
  has_many :labelings, dependent: :destroy

  class << self
    def synchronize(repository, labels_by_github_api)
      labels_id = labels_by_github_api.map(&:id)
      repository.labels.where.not(id: labels_id).delete_all

      hash_list = labels_by_github_api.map(&:to_h)
      upsert_all(hash_list) if hash_list.any?
    end
  end
end
