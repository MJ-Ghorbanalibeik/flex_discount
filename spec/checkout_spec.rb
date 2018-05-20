require 'models/checkout'
require 'models/flat_discount'
require 'models/order_item'
include Models

RSpec.describe Checkout do
  it 'has an initializer that requires promotional_rule as argument' do
    expect{Checkout.new()}.to raise_error(error = ArgumentError)
    expect{Checkout.new('any type other than decendants of BaseDiscount')}.to raise_error(error = TypeError)
  end

  it 'has a "scan" method that takes product or order_item as argument and adds to its items' do
    flat_discount = FlatDiscount.new(10)
    co = Checkout.new(flat_discount)
    order_item = OrderItem.new(Product.new(1, 'Curry Sauce', 1.95))
    expect(co).to respond_to(:scan).with(1).argument
    items_size = co.items.size
    expect{co.scan(order_item)}.to change{co.items.size}.from(0).to(1)
  end
end
