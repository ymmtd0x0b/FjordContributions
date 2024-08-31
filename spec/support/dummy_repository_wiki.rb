# frozen_string_literal: true

module DummyRepositoryWiki
  def self.init(repository_name, files: ['test'], author: 'tester')
    tmpdir = Dir.mktmpdir
    tmpdir_realpath = File.realpath tmpdir

    Dir.chdir(tmpdir_realpath) do
      git = Git.init("#{repository_name}.wiki.git")
      git.config('user.name', author)
      git.config('user.email', 'test@example.com')

      files.each do |file_name|
        file = "#{file_name}.md"
        File.write("#{repository_name}.wiki.git/#{file}", 'test')
        git.add(file)
        git.commit('first commit')
      end
    end

    yield tmpdir_realpath
  ensure
    FileUtils.remove_entry_secure tmpdir_realpath if tmpdir_realpath
  end
end
