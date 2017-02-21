class Order < ApplicationRecord
  has_many :orderings
  has_many :products, through: :orderings
end
