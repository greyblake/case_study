class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :monument_id, null: false
      t.string  :name
      t.text    :description

      t.timestamps
    end

    add_index :pictures, :monument_id

    if respond_to?(:add_foreign_key)
      add_foreign_key :pictures, :monuments
    end
  end
end
