class Api::ProductsController < ApplicationController
  def products
    @products = Product.orders_in_range(params).as_json
  end
end
