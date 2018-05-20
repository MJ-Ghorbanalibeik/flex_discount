require 'models/step_discount'
require 'models/order_item'
include Models

RSpec.describe StepDiscount do
  it 'should calculate discount correctly' do
    step_discount = StepDiscount.new(1, 10)
    step_discount.add_step(2, 20)
    step_discount.add_step(3, 30)
    step_discount.add_step(4, 40)
    items = []
    items.push OrderItem.new(Product.new(2, 'Pizza', 5.99))
    expect(step_discount.calculate_discount(items)).to eq(0)
    items.push OrderItem.new(Product.new(2, 'Pizza', 5.99))
    expect(step_discount.calculate_discount(items)).to eq(((2 * 5.99)*1/100).round(2))
    items.push OrderItem.new(Product.new(2, 'Pizza', 5.99), 2)
    expect(step_discount.calculate_discount(items)).to eq(((4 * 5.99)*2/100).round(2))
    items.push OrderItem.new(Product.new(3, 'Men T-Shirt', 25))
    expect(step_discount.calculate_discount(items)).to eq(((4 * 5.99 + 25)*4/100).round(2))
  end
end
