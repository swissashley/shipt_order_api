class Api::CustomersController < ApplicationController
  def orders
    @customer = Customer.find(params[:id])
    @all_orders = @customer.all_orders.as_json if @customer
  end
end
