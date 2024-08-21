class CreateRepositories < ActiveRecord::Migration[7.2]
  def change
    create_table :repositories do |t|
      t.string :name, null: false
      t.string :avatar_url

      t.timestamps
    end
  end
end
