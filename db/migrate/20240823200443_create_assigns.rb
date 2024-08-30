class CreateAssigns < ActiveRecord::Migration[7.2]
  def change
    create_table :assigns do |t|
      t.references :assignable, polymorphic: true, null: false
      t.references :user,       foreign_key: true, null: false

      t.timestamps
    end
    add_index :assigns, %i[assignable_type assignable_id user_id], unique: true
  end
end
