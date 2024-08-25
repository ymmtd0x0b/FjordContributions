class CreateWikis < ActiveRecord::Migration[7.2]
  def change
    create_table :wikis do |t|
      t.references :repository,    null: false, foreign_key: true
      t.references :author,        null: false, foreign_key: { to_table: :users }
      t.string :title,             null: false
      t.string :first_commit_hash, null: false

      t.timestamps
    end
    add_index :wikis, %i[repository_id first_commit_hash], unique: true
  end
end
