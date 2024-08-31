# frozen_string_literal: true

class Wiki < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :repository

  class << self
    def synchronize(wikis_by_git, user)
      user.wikis
          .where.not(first_commit_hash: wikis_by_git.map(&:first_commit_hash))
          .delete_all

      hash_list = wikis_by_git.map(&:to_h)
      upsert_all(hash_list, unique_by: %i[repository_id first_commit_hash]) if hash_list.any?
    end
  end
end
