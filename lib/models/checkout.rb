require 'models/base_discount'

module Models
  class Checkout
    attr_reader :items

    def initialize(promotional_rule)
      if !(promotional_rule.class < BaseDiscount)
        raise TypeError
      end
      @discount_model = promotional_rule
      @items = []
    end

    def scan(order_item)
      previous_index = @items.index { |item| item.product.product_code == order_item.product.product_code }
      if previous_index != nil
        items[previous_index].count += order_item.count
      else
        @items.push order_item
      end
    end

    def total
      @items.inject(0) { |sum, order_item| order_item.product.price * order_item.count } - @discount_model.calculate_discount(@items)
    end
  end
end
