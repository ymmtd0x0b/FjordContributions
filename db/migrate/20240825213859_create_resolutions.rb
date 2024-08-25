class CreateResolutions < ActiveRecord::Migration[7.2]
  def change
    create_table :resolutions do |t|
      t.references :issue, null: false, foreign_key: true
      t.references :pull_request, null: false, foreign_key: true

      t.timestamps
    end
    add_index :resolutions, %i[issue_id pull_request_id], unique: true
  end
end
