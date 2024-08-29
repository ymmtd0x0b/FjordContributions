# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_08_26_214346) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assigns", force: :cascade do |t|
    t.string "assignable_type", null: false
    t.bigint "assignable_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignable_type", "assignable_id"], name: "index_assigns_on_assignable"
    t.index ["user_id"], name: "index_assigns_on_user_id"
  end

  create_table "issues", force: :cascade do |t|
    t.string "title", null: false
    t.integer "number", null: false
    t.bigint "author_id", null: false
    t.bigint "repository_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_issues_on_author_id"
    t.index ["repository_id", "number"], name: "index_issues_on_repository_id_and_number", unique: true
    t.index ["repository_id"], name: "index_issues_on_repository_id"
  end

  create_table "labelings", force: :cascade do |t|
    t.bigint "issue_id", null: false
    t.bigint "label_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id", "label_id"], name: "index_labelings_on_issue_id_and_label_id", unique: true
    t.index ["issue_id"], name: "index_labelings_on_issue_id"
    t.index ["label_id"], name: "index_labelings_on_label_id"
  end

  create_table "labels", force: :cascade do |t|
    t.string "name", null: false
    t.string "color", null: false
    t.bigint "repository_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_id", "name"], name: "index_labels_on_repository_id_and_name", unique: true
    t.index ["repository_id"], name: "index_labels_on_repository_id"
  end

  create_table "pull_requests", force: :cascade do |t|
    t.integer "number", null: false
    t.bigint "repository_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_id", "number"], name: "index_pull_requests_on_repository_id_and_number", unique: true
    t.index ["repository_id"], name: "index_pull_requests_on_repository_id"
  end

  create_table "repositories", force: :cascade do |t|
    t.string "name", null: false
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resolutions", force: :cascade do |t|
    t.bigint "issue_id", null: false
    t.bigint "pull_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id", "pull_request_id"], name: "index_resolutions_on_issue_id_and_pull_request_id", unique: true
    t.index ["issue_id"], name: "index_resolutions_on_issue_id"
    t.index ["pull_request_id"], name: "index_resolutions_on_pull_request_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "pull_request_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pull_request_id", "user_id"], name: "index_reviews_on_pull_request_id_and_user_id", unique: true
    t.index ["pull_request_id"], name: "index_reviews_on_pull_request_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login", null: false
    t.string "name"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  create_table "wikis", force: :cascade do |t|
    t.bigint "repository_id", null: false
    t.bigint "author_id", null: false
    t.string "title", null: false
    t.string "first_commit_hash", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_wikis_on_author_id"
    t.index ["repository_id", "first_commit_hash"], name: "index_wikis_on_repository_id_and_first_commit_hash", unique: true
    t.index ["repository_id"], name: "index_wikis_on_repository_id"
  end

  add_foreign_key "assigns", "users"
  add_foreign_key "issues", "repositories"
  add_foreign_key "labelings", "issues"
  add_foreign_key "labelings", "labels"
  add_foreign_key "labels", "repositories"
  add_foreign_key "pull_requests", "repositories"
  add_foreign_key "resolutions", "issues"
  add_foreign_key "resolutions", "pull_requests"
  add_foreign_key "reviews", "pull_requests"
  add_foreign_key "reviews", "users"
  add_foreign_key "wikis", "repositories"
  add_foreign_key "wikis", "users", column: "author_id"
end
