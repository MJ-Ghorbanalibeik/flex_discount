module Models
  class Product
    attr_reader :product_code, :name, :price, :product_group_code

    def initialize(product_code, name, price, product_group_code = nil)
      @product_code = product_code
      @name = name
      @price = price
      @product_group_code = product_group_code
    end
  end
end
