require 'models/item_discount'
require 'models/order_item'
include Models

RSpec.describe ItemDiscount do
  it 'should calculate discount correctly' do
    item_discount = ItemDiscount.new(2, 2, 100 * 2/5.99)
    items = []
    items.push OrderItem.new(Product.new(2, 'Pizza', 5.99))
    items.push OrderItem.new(Product.new(1, 'Curry Sauce', 1.95))
    items.push OrderItem.new(Product.new(2, 'Pizza', 5.99))
    expect(item_discount.calculate_discount(items)).to eq(4)
  end
end
