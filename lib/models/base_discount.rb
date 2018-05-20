module Models
  class BaseDiscount
    def initialize()
    end

    def calculate_discount(order)
      fail NotImplementedError, 'A discount type must be used!'
    end
  end
end
