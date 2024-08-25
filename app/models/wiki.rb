# frozen_string_literal: true

class Wiki < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :repository
end
