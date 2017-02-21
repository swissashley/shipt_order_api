class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validate :in_stock?

  has_many :category_products
  has_many :categories, through: :category_products
  has_many :orderings
  has_many :orders, through: :orderings
  private

  def in_stock?
    errors.add(:stock, "#{name} is out-of-stock") if quantity < 0
  end
end
