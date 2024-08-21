class CreateLabels < ActiveRecord::Migration[7.2]
  def change
    create_table :labels do |t|
      t.string :name,  null: false
      t.string :color, null: false
      t.references :repository, null: false, foreign_key: true

      t.timestamps
    end
    add_index :labels, %i[repository_id name], unique: true
  end
end
