class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :quantity, default: 0
      t.timestamps
    end
    add_index :products, :name, unique: true
  end
end
