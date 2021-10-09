class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :url
      t.boolean :active, null: false, default: true

      t.timestamps
    end
    add_index :stores, :url, unique: true
  end
end
