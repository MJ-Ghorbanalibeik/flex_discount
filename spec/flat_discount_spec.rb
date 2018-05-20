require 'models/flat_discount'
require 'models/order_item'
include Models

RSpec.describe FlatDiscount do
  it 'should calculate discount correctly' do
    flat_discount = FlatDiscount.new(10, 30)
    items = []
    items.push OrderItem.new(Product.new(1, 'Curry Sauce', 1.95))
    items.push OrderItem.new(Product.new(2, 'Pizza', 5.99))
    items.push OrderItem.new(Product.new(3, 'Men T-Shirt', 25))
    expect(flat_discount.calculate_discount(items)).to eq(((1.95 + 5.99 + 25)*10/100).round(2))
  end
end
