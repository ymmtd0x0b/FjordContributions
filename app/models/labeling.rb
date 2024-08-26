# frozen_string_literal: true

class Labeling < ApplicationRecord
  belongs_to :issue
  belongs_to :label
end
