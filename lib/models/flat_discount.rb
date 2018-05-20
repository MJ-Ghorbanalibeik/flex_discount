require 'models/base_discount'

module Models
  class FlatDiscount < BaseDiscount
    attr_reader :discount_percentage, :min_order_value

    def initialize(discount_percentage, min_order_value = 0)
      @discount_percentage = discount_percentage
      @min_order_value = min_order_value
    end

    def calculate_discount(order)

    end
  end
end
