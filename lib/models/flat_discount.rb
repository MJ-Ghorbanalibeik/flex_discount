require 'models/base_discount'

module Models
  class FlatDiscount < BaseDiscount
    attr_reader :discount_percentage, :min_order_value

    def initialize(discount_percentage, min_order_value = 0)
      @discount_percentage = discount_percentage
      @min_order_value = min_order_value
    end

    def calculate_discount(items, previous_discount = 0)
      flat_order_value = 0
      items.each{ |item| flat_order_value += item.product.price * item.count }
      return ((flat_order_value - previous_discount) * @discount_percentage / 100).round(2) if flat_order_value >= @min_order_value
      return 0
    end
  end
end
