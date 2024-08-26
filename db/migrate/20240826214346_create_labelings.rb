class CreateLabelings < ActiveRecord::Migration[7.2]
  def change
    create_table :labelings do |t|
      t.references :issue, null: false, foreign_key: true
      t.references :label, null: false, foreign_key: true

      t.timestamps
    end
    add_index :labelings, %i[issue_id label_id], unique: true
  end
end
