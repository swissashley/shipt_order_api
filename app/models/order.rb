class Order < ApplicationRecord
  validates :customer, presence: true
  belongs_to :customer
  has_many :orderings
  has_many :products, through: :orderings, source: :product
end
