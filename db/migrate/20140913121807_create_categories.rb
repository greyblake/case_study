class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :user_id, null: false
      t.string  :name   , null: false

      t.timestamps
    end

    add_index :categories, :user_id

    if respond_to?(:add_foreign_key)
      add_foreign_key :categories, :users
    end
  end
end
