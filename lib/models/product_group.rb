module Models
  class ProductGroup
    attr_reader :product_group_code, :name

    def initialize(product_group_code, name)
      @product_group_code = product_group_code
      @name = name
    end
  end
end
