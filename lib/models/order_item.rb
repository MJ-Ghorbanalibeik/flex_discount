require 'models/product'

module Models
  class OrderItem
    attr_reader :product
    attr_accessor :count

    def initialize(product, count = 1)
      @product = product
      @count = count
    end
  end
end
