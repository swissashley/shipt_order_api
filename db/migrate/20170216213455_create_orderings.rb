class CreateOrderings < ActiveRecord::Migration[5.0]
  def change
    create_table :orderings do |t|
      t.integer :order_id, null: false
      t.integer :product_id, null: false
      t.integer :number_purchased, null: false
      t.timestamps
    end
    add_index :orderings, :order_id
    add_index :orderings, :product_id
    add_index :orderings, [:order_id, :product_id], unique: true
  end
end
