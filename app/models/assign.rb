# frozen_string_literal: true

class Assign < ApplicationRecord
  belongs_to :assignable, polymorphic: true
  belongs_to :user
end
