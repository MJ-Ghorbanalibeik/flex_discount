module Models
  class BaseDiscount
    def initialize()
    end

    def calculate_discount(items, previous_discount = 0)
      fail NotImplementedError, 'A discount type must be used!'
    end
  end
end
