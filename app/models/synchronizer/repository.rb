# frozen_string_literal: true

module Synchronizer
  class Repository
    def call(payload)
      repository = payload[:repository]

      latest_reposiory = GitHub::Repository.find_by(id: repository.id)
      repository.update!(latest_reposiory.to_h)
    end
  end
end
