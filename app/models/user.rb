# frozen_string_literal: true

class User < ApplicationRecord
  has_many :issues # rubocop:disable Rails/HasManyOrHasOneDependent
end
