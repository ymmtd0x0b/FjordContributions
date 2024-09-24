# frozen_string_literal: true

module Git
  class Wiki
    include ActiveSupport::Configurable
    config_accessor :github_url, instance_accessor: false

    attr_reader :first_commit_hash

    def initialize(repository_id:, file_data: { user_id:, title:, first_commit_hash:, created_at:, updated_at: })
      @repository_id = repository_id
      @author_id = file_data[:user_id]
      @title = file_data[:title]
      @first_commit_hash = file_data[:first_commit_hash]
      @created_at = file_data[:created_at]
      @updated_at = file_data[:updated_at]
    end

    def to_h
      { repository_id: @repository_id,
        author_id: @author_id,
        title: @title,
        first_commit_hash: @first_commit_hash,
        created_at: @created_at,
        updated_at: @updated_at }
    end

    class << self
      def created_by(repository, user)
        Dir.mktmpdir do |dir|
          Git.clone("#{github_url}/#{repository.name}.wiki.git", dir)

          git = Git.open dir
          wikis = git.lib.ls_files

          wikis.filter_map do |file_name, _|
            file_log = git.log.object("#{dir}/#{file_name}")
            next unless [user.login, user.name].include? file_log.last.author.name

            new(repository_id: repository.id, file_data: convert_to_hash(user, file_name, file_log))
          end
        rescue Git::Error => e
          log_error(e)
          []
        end
      end

      private

      def convert_to_hash(user, file_name, file_log)
        { user_id: user.id,
          title: file_name.delete_suffix('.md'),
          first_commit_hash: file_log.last.sha,
          created_at: file_log.last.author_date,
          updated_at: file_log.first.author_date }
      end

      def log_error(exception)
        # NOTE: exception の例
        #       - fatal: repository 'https://github.com/sample/repository.wiki.git/' not found
        #       - fatal: unable to access 'https://github.com/sample/repository.wiki.git/': Could not resolve host: github.com
        Rails.logger.error "[Git] #{exception.result.stderr}"
      end
    end
  end
end
