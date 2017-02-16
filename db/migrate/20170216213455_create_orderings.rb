class CreateOrderings < ActiveRecord::Migration[5.0]
  def change
    create_table :orderings do |t|
      t.integer :order_id, null: false
      t.integer :product_id, null: false
      t.integer :number_purchased, null: false

      t.timestamps
    end
  end
end
