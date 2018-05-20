require 'models/base_discount'

module Models
  class Checkout
    attr_reader :total, :items

    def initialize(promotional_rule)
      if !(promotional_rule.class < BaseDiscount)
        raise TypeError
      end
      @discount_model = promotional_rule
      @items = []
      @total = 0
    end

    def scan(order_item)
      @items += [order_item]
    end
  end
end
