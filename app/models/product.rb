class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validate :in_stock?

  has_many :category_products
  has_many :categories, through: :category_products
  has_many :orderings
  has_many :orders, through: :orderings

  def self.orders_in_range(params)
      @products = Order.orders_in_range(params)
        .joins(:orderings, :products)
        .select("products.id product_id, products.name product_name, sum(orderings.number_purchased) sold, orders.updated_at updated_at")
        .group("products.id, orders.updated_at")
      @products
	end

  private

  def in_stock?
    errors.add(:stock, "#{name} is out-of-stock") if quantity < 0
  end
end
