class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :user_id, null: false
      t.string  :name   , null: false

      t.timestamps
    end

    add_index :collections, :user_id

    if respond_to?(:add_foreign_key)
      add_foreign_key :collections, :users
    end
  end
end
