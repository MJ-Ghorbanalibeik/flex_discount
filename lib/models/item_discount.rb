require 'models/base_discount'

module Models
  class ItemDiscount < BaseDiscount
    attr_reader :from_product_code, :from_product_min_count, :discount_percentage, :to_product_code, :to_product_min_count

    def initialize(from_product_code, from_product_min_count, discount_percentage, to_product_code = nil, to_product_min_count = nil, from_product_multiple_of = nil, to_product_multiple_of = nil)
      @from_product_code = from_product_code
      @from_product_min_count = from_product_min_count
      @discount_percentage = discount_percentage
      @to_product_code = to_product_code
      @to_product_min_count = to_product_min_count || 1
      @from_product_multiple_of = from_product_min_count || 1
      @to_product_multiple_of = to_product_multiple_of || 1
    end

    def calculate_discount(items, previous_discount = 0)
      flat_order_value = 0
      from_product_count = 0
      from_product_price = 0
      to_product_count = 0
      to_product_price = 0
      items.each do |item|
        flat_order_value += item.product.price * item.count
        if item.product.product_code == @from_product_code
          from_product_count += item.count
          from_product_price = item.product.price
        end
        if item.product.product_code == @to_product_code
          to_product_count += item.count
          to_product_price = item.product.price
        end
      end
      discount = 0
      if from_product_count >= @from_product_min_count
        # Discount on from_product
        if @to_product_code == nil
          number_of_applied_times = (from_product_count / @from_product_multiple_of).floor
          discount = number_of_applied_times * @from_product_multiple_of * from_product_price * @discount_percentage / 100
        elsif to_product_count > @to_product_min_count
          number_of_applied_times = [(from_product_count / @from_product_multiple_of).floor, (to_product_count / @to_product_multiple_of).floor].min
          discount = number_of_applied_times * @to_product_multiple_of * to_product_price * @discount_percentage / 100
        end
      end
      return discount.round(2)
    end
  end
end
