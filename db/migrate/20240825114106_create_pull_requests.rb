class CreatePullRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :pull_requests do |t|
      t.integer :number       , null: false
      t.references :repository, null: false, foreign_key: true

      t.timestamps
    end
    add_index :pull_requests, %i[repository_id number], unique: true
  end
end
