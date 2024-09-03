# frozen_string_literal: true

module Settable
  extend ActiveSupport::Concern

  def set_repository
    @repository = Repository.find_by(name: ENV['REPOSITORY_NAME'])
  end
end
