class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.string :status, default: "Waiting for delivery"
      t.timestamps
    end
  end
end
