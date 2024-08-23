# frozen_string_literal: true

class User < ApplicationRecord
  has_many :issues, foreign_key: :author_id # rubocop:disable Rails/HasManyOrHasOneDependent,Rails/InverseOf
end
