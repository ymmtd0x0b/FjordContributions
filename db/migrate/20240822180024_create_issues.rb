class CreateIssues < ActiveRecord::Migration[7.2]
  def change
    create_table :issues do |t|
      t.string :title,          null: false
      t.integer :number,        null: false
      t.references :author,     null: false
      t.references :repository, null: false, foreign_key: true

      t.timestamps
    end
    add_index :issues, %i[repository_id number], unique: true
  end
end
