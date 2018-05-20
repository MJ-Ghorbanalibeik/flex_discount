require 'models/base_discount'

module Models
  class ItemDiscount < BaseDiscount
    attr_reader :from_product_code, :from_product_min_count, :to_product_code, :to_product_min_count, :discount_percentage

    def initialize(from_product_code, from_product_min_count, to_product_code, to_product_min_count, discount_percentage)
      @from_product_code = from_product_code
      @from_product_min_count = from_product_min_count
      @to_product_code = to_product_code
      @to_product_min_count = to_product_min_count
      @discount_percentage = discount_percentage
    end

    def calculate_discount(order)

    end
  end
end
