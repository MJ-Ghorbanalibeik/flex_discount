require 'models/base_discount'

module Models
  class Checkout
    attr_reader :items

    def initialize(promotional_rules)
      if promotional_rules.class != Array || !(promotional_rules.map { |rule| rule.class < BaseDiscount }.all? { |result| result })
        raise TypeError
      end
      @discounts = promotional_rules
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
      total_discount = 0
      @discounts.each { |rule| total_discount += rule.calculate_discount(@items, total_discount) }
      grand_total = @items.inject(0) { |sum, order_item| sum += order_item.product.price * order_item.count }
      return (grand_total - total_discount).round(2)
    end
  end
end
