# frozen_string_literal: true

module Synchronizer
  class CreatedWiki
    def call(payload)
      repository = payload[:repository]
      user = payload[:user]

      wikis = Git::Wiki.created_by(repository, user)
      Wiki.synchronize(wikis, user)
    end
  end
end
