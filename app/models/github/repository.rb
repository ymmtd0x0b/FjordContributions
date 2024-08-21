# frozen_string_literal: true

module GitHub
  class Repository
    def initialize(id:, name:, avatar_url:, created_at:, updated_at:)
      @id = id
      @name = name
      @avatar_url = avatar_url
      @created_at = created_at
      @updated_at = updated_at
    end

    def to_h
      { id: @id,
        name: @name,
        avatar_url: @avatar_url,
        created_at: @created_at,
        updated_at: @updated_at }
    end

    class << self
      def find_by(id: nil, name: nil)
        client = GitHub::APIClient.new
        repo = client.repository(id:, name:)
        return nil if repo.nil?

        new(id: repo.id, name: repo.full_name, avatar_url: repo.owner.avatar_url, created_at: repo.created_at, updated_at: repo.updated_at)
      end
    end
  end
end
