# frozen_string_literal: true

repository_id = ENV['BOOTCAMP_REPOSITORY_ID']
return if Repository.exists?(id: repository_id)

repo_data = GitHub::Repository.find_by(id: repository_id)
if repo_data
  Repository.create!(repo_data.to_h)
else
  puts 'データの取得に失敗しました。詳細は /log/development.log を確認してください。' # rubocop:disable Rails/Output
end
