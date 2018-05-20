require 'models/checkout'
require 'models/flat_discount'
require 'models/item_discount'
require 'models/order_item'
include Models

RSpec.describe Checkout do
  it 'has an initializer that requires promotional_rule as argument' do
    expect{Checkout.new()}.to raise_error(error = ArgumentError)
    expect{Checkout.new('any type other than decendants of BaseDiscount')}.to raise_error(error = TypeError)
  end

  it 'has a "scan" method that takes product or order_item as argument and adds to its items' do
    flat_discount = FlatDiscount.new(10)
    co = Checkout.new([flat_discount])
    order_item = OrderItem.new(Product.new(1, 'Curry Sauce', 1.95))
    expect(co).to respond_to(:scan).with(1).argument
    items_size = co.items.size
    expect{co.scan(order_item)}.to change{co.items.size}.from(0).to(1)
  end

  it 'has a "total" method that does not take any argument and returns total value of order' do
    flat_discount = FlatDiscount.new(1, 10)
    co = Checkout.new([flat_discount])
    co.scan OrderItem.new(Product.new(1, 'Curry Sauce', 1.95), 3)
    expect(co.total).to eq(5.85)
  end

  it 'should accumulate identical order_items' do
    flat_discount = FlatDiscount.new(10)
    co = Checkout.new([flat_discount])
    co.scan OrderItem.new(Product.new(1, 'Curry Sauce', 1.95))
    expect{co.scan OrderItem.new(Product.new(1, 'Curry Sauce', 1.95), 2)}.not_to change{co.items.size}
    expect(co.items[0].count).to eq(3)
  end

  it 'should calculate_discount correctly in integration 1' do
    flat_discount = FlatDiscount.new(10, 30)
    item_discount = ItemDiscount.new(2, 2, 100 * 2/5.99)
    co = Checkout.new([flat_discount, item_discount])
    co.scan OrderItem.new(Product.new(1, 'Curry Sauce', 1.95))
    co.scan OrderItem.new(Product.new(2, 'Pizza', 5.99))
    co.scan OrderItem.new(Product.new(3, 'Men T-Shirt', 25))
    expect(co.total).to eq(29.65)
  end

  it 'should calculate_discount correctly in integration 2' do
    flat_discount = FlatDiscount.new(10, 30)
    item_discount = ItemDiscount.new(2, 2, 100 * 2/5.99)
    co = Checkout.new([flat_discount, item_discount])
    co.scan OrderItem.new(Product.new(2, 'Pizza', 5.99))
    co.scan OrderItem.new(Product.new(1, 'Curry Sauce', 1.95))
    co.scan OrderItem.new(Product.new(2, 'Pizza', 5.99))
    expect(co.total).to eq(9.93)
  end

  it 'should calculate_discount correctly in integration 3' do
    flat_discount = FlatDiscount.new(10, 30)
    item_discount = ItemDiscount.new(2, 2, 100 * 2/5.99)
    co = Checkout.new([item_discount, flat_discount])
    co.scan OrderItem.new(Product.new(2, 'Pizza', 5.99))
    co.scan OrderItem.new(Product.new(1, 'Curry Sauce', 1.95))
    co.scan OrderItem.new(Product.new(2, 'Pizza', 5.99))
    co.scan OrderItem.new(Product.new(3, 'Men T-Shirt', 25))
    expect(co.total).to eq(31.44)
  end
end
