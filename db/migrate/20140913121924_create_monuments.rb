class CreateMonuments < ActiveRecord::Migration
  def change
    create_table :monuments do |t|
      t.integer :category_id  , null: false
      t.integer :collection_id, null: false
      t.string  :name         , null: false
      t.text    :description

      t.timestamps
    end

    add_index :monuments, :category_id
    add_index :monuments, :collection_id

    if respond_to?(:add_foreign_key)
      add_foreign_key :monuments, :categories
      add_foreign_key :monuments, :collections
    end
  end
end
