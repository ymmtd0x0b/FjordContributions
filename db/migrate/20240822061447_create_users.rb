class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :login, null: false
      t.string :name
      t.string :avatar_url

      t.timestamps
    end
    add_index :users, :login, unique: true
  end
end
