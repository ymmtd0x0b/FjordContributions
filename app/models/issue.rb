# frozen_string_literal: true

class Issue < ApplicationRecord
  belongs_to :author, class_name: 'User', optional: true
  belongs_to :repository
end
