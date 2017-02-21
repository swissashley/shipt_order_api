# Ordering API

The application is created with Rails and using Postgresql for its database.

## Run

In your terminal:

```bash
git clone https://github.com/swissashley/shipt_order_api.git
cd order_api
bundle install
open -a postgres
rake db:reset
rails s
```
Then open:

- [API call for Customer Order][api1]
- [API call for specific time interval][api2]

[api1]: http://localhost:3000/api/customers/1/orders
[api2]: http://localhost:3000/api/products/products/?start_date=01-01-2017&end_date=02-23-2017&interval=day

# SQL query for Question 3
** Assuming we want to get records for customer_id = 1
```SQL
select customers.id as customer_id,
 customers.first_name as customer_first_name,
 categories.id as category_id,
 categories.name as category_name,
 orderings.number_purchased
 from customers
 join orders on customers.id = orders.customer_id
 join orderings on orders.id = orderings.order_id
 join products on orderings.product_id = products.id
 join category_products on products.id = category_products.product_id
 join categories on category_products.category_id = categories.id
 where customer_id = 1;

 Output:
 customer_id | customer_first_name | category_id | category_name | number_purchased
-------------+---------------------+-------------+---------------+------------------
          1 | John                |           1 | Bouquets      |               15

```

## Schema

```rb
create_table "categories", force: :cascade do |t|
  t.string   "name",       null: false
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
  t.index ["name"], name: "index_categories_on_name", unique: true, using: :btree
end

create_table "category_products", force: :cascade do |t|
  t.integer  "category_id", null: false
  t.integer  "product_id",  null: false
  t.datetime "created_at",  null: false
  t.datetime "updated_at",  null: false
  t.index ["category_id", "product_id"], name: "index_category_products_on_category_id_and_product_id", unique: true, using: :btree
  t.index ["category_id"], name: "index_category_products_on_category_id", using: :btree
  t.index ["product_id"], name: "index_category_products_on_product_id", using: :btree
end

create_table "customers", force: :cascade do |t|
  t.string   "first_name", null: false
  t.string   "last_name",  null: false
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
end

create_table "orderings", force: :cascade do |t|
  t.integer  "order_id",         null: false
  t.integer  "product_id",       null: false
  t.integer  "number_purchased", null: false
  t.datetime "created_at",       null: false
  t.datetime "updated_at",       null: false
  t.index ["order_id", "product_id"], name: "index_orderings_on_order_id_and_product_id", unique: true, using: :btree
  t.index ["order_id"], name: "index_orderings_on_order_id", using: :btree
  t.index ["product_id"], name: "index_orderings_on_product_id", using: :btree
end

create_table "orders", force: :cascade do |t|
  t.integer  "customer_id",                                  null: false
  t.string   "status",      default: "Waiting for delivery"
  t.datetime "created_at",                                   null: false
  t.datetime "updated_at",                                   null: false
  t.index ["customer_id"], name: "index_orders_on_customer_id", using: :btree
end

create_table "products", force: :cascade do |t|
  t.string   "name",                   null: false
  t.integer  "quantity",   default: 0
  t.datetime "created_at",             null: false
  t.datetime "updated_at",             null: false
  t.index ["name"], name: "index_products_on_name", unique: true, using: :btree
end

```

## Additional Questions 1: Lists For One-Click Ordering of Bulk Items.

The idea of a List is pretty much the same as an Order: it is also comprised by
products and the quantity you would like to purchase.

I would add another column in Orders table: Type, stating if a record in the table
is either a List or an Order. And of course we would like to create some other
tables to store customer's information such as their credit card information and
shipping method, shipping address ... etc.

Once the customer click on the purchase button, we duplicate the "List record" into
an "Order record", and process the order just like the other orders.

Pros for this approach is it's very easy to maintain both Order and List records
in one table, and we don't need extra tables to save the list records. It could be
an issue in the future if we want to add different features for List. I.e. If we
want to add recursive purchasing feature and need extra information for a List record,
it won't be appropriate to put the extra info into the same table.


## Additional Questions 2: Inventory Distribution

I can think of 2 ways to handle the distribution issue:
- When a customer adds a product into his/her order, we temporary remove the number
of purchased from the inventory so that other customer won't be able to purchase
the same item when it's out-of-stock. However this could cause a lot of database
transactions to update the inventory, if the first customer decide not to purchase
the item, we have to add the inventory back.
- Update the inventory at check out. We only check if the product is still in stock
 at this moment. We can handle the error message and send it back to the client side
 so that a customer can remove the product from the order and won't cause too many
 database updates.
