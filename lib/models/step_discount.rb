require 'models/base_discount'

module Models
  class StepDiscount < BaseDiscount
    attr_reader :steps

    def initialize(step_discount_percentage, step_order_value = 0)
      @steps = []
      self.add_step(step_discount_percentage, step_order_value)
    end

    def add_step(step_discount_percentage, step_order_value)
      @steps += [{step_discount_percentage: step_discount_percentage, step_order_value: step_order_value}]
    end

    def calculate_discount(items)

    end
  end
end
