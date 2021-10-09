class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :product_id
      t.string :name
      t.decimal :price, precision: 8, scale: 2, null: false, default: 0.00
      t.decimal :original_price, precision: 8, scale: 2, null: false, default: 0.00
      t.integer :number_of_installments, null: false, default: 0
      t.decimal :installments_full_price, precision: 8, scale: 2, null: false, default: 0.00
      t.string :image_url
      t.integer :available_quantity, null: false, default: 0
      t.references :store, null: false, foreign_key: true
      t.boolean :active, null: false, default: true

      t.timestamps
    end
    add_index :products, :product_id, unique: true
  end
end
