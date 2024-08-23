# frozen_string_literal: true

class User < ApplicationRecord
  has_many :issues, foreign_key: :author_id, inverse_of: :author # rubocop:disable Rails/HasManyOrHasOneDependent
end
