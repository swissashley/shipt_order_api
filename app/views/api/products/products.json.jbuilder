json.array!(@products) do |product|
	p product
  json.partial!('product', product: product)
end
