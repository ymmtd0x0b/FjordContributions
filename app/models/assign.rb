# frozen_string_literal: true

class Assign < ApplicationRecord
  belongs_to :assignable, polymorphic: true
  belongs_to :user

  class << self
    def synchronize(model_name, items_by_github_api, user)
      user.assigns.where(assignable_type: model_name).where.not(assignable_id: items_by_github_api.map(&:id)).delete_all

      hash_list = items_by_github_api.map { |item| { assignable_type: model_name, assignable_id: item.id, user_id: user.id } }
      insert_all(hash_list, unique_by: %i[assignable_type assignable_id user_id]) if hash_list.any?
    end
  end
end
