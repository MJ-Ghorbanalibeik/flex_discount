require 'models/base_discount'

module Models
  class StepDiscount < BaseDiscount
    attr_reader :steps

    def initialize(step_discount_percentage, step_order_value = 0)
      @steps = []
      self.add_step(step_discount_percentage, step_order_value)
    end

    def add_step(step_discount_percentage, step_order_value)
      @steps.push({step_discount_percentage: step_discount_percentage, step_order_value: step_order_value})
    end

    def calculate_discount(items, previous_discount = 0)
      flat_order_value = 0
      items.each{ |item| flat_order_value += item.product.price * item.count }
      appropriate_discount = steps.select { |item| item[:step_order_value] < flat_order_value }.sort_by { |item| item[:step_order_value] }.last
      return ((flat_order_value - previous_discount) * appropriate_discount[:step_discount_percentage] / 100).round(2) if appropriate_discount != nil
      return 0
    end
  end
end
