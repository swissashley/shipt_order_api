class Order < ApplicationRecord
  has_many :orderings
  has_many :products, through: :orderings

  def self.orders_in_range(params)
    start_date = Date.strptime(params[:start_date], '%m-%d-%Y')
    end_date = Date.strptime(params[:end_date], '%m-%d-%Y')
    interval = params[:interval]
    interval ||= 'month'
    @orders = Order.where(updated_at: start_date..end_date)
    @orders
  end

end
