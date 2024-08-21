# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 既存のデータを削除
Repository.destroy_all
Label.destroy_all

# 初期データの投入
repo = GitHub::Repository.find_by(name: 'fjordllc/bootcamp')
repository = Repository.create!(repo.to_h)

labels = GitHub::Label.registered_by(repository)
labels.map { |label| Label.create!(label.to_h) }
