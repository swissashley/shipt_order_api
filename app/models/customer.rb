class Customer < ApplicationRecord
  validates :first_name, :last_name, presence: true

  has_many :orders
  has_many :products, through: :orders

  def all_orders
		orders.joins(:orderings, :products)
			.select('orders.id order_id, orders.status, orders.updated_at')
			.select('orderings.number_purchased number_purchased')
			.select('products.id product_id, products.name product_name')
	end
end
