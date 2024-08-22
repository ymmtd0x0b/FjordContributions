# frozen_string_literal: true

module GitHub
  class User
    def initialize(id:, login:, name:, avatar_url:)
      @id = id
      @login = login
      @name = name
      @avatar_url = avatar_url
    end

    def to_h
      { id: @id,
        login: @login,
        name: @name,
        avatar_url: @avatar_url }
    end

    class << self
      def find_by(id: nil, login: nil)
        client = GitHub::APIClient.new
        user = client.user(id || login)
        new(id: user.id, login: user.login, name: user.name, avatar_url: user.avatar_url) if user
      end
    end
  end
end
