# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Customer.destroy_all
Category.destroy_all
Product.destroy_all
CategoryProduct.destroy_all
Order.destroy_all
Ordering.destroy_all

Customer.create!(first_name: "John", last_name: "Raze")
Customer.create!(first_name: "Victor", last_name: "Lin")

Category.create!(name: "Bouquets")
Category.create!(name: "Fruits")

Product.create!(name: "Brooch Bouquet", quantity: 30)
Product.create!(name: "Paper Flower Bouquet", quantity: 30)
Product.create!(name: "Apple", quantity: 30)
Product.create!(name: "Banana", quantity: 30)
Product.create!(name: "Grapes", quantity: 30)

CategoryProduct.create!(category_id: 1, product_id: 1)
CategoryProduct.create!(category_id: 1, product_id: 2)
CategoryProduct.create!(category_id: 2, product_id: 3)
CategoryProduct.create!(category_id: 2, product_id: 4)
CategoryProduct.create!(category_id: 2, product_id: 5)

Order.create!(customer_id: 1)
Order.create!(customer_id: 2)
Order.create!(customer_id: 2)

Ordering.create!(order_id: 1, product_id: 1, number_purchased: 15)
Ordering.create!(order_id: 2, product_id: 2, number_purchased: 1)
Ordering.create!(order_id: 2, product_id: 3, number_purchased: 2)
Ordering.create!(order_id: 3, product_id: 1, number_purchased: 3)
Ordering.create!(order_id: 3, product_id: 4, number_purchased: 3)
Ordering.create!(order_id: 3, product_id: 5, number_purchased: 3)

=begin
select customers.id as customer_id,
 customers.first_name as customer_first_name,
 categories.id as category_id,
 categories.name as category_name,
 orderings.number_purchased
 from customers
 join orders on customers.id = orders.customer_id
 join orderings on orders.id = orderings.order_id
 join products on orderings.product_id = products.id
 join categories on products.category_id = categories.id
 where customers.first_name = 'John';
=end
