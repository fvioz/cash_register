# frozen_string_literal: true
# typed: true

module Products
  class ProductService
    extend T::Sig

    sig { params(code: String).returns(T.nilable(ProductEntity)) }
    def self.find_by_code(code)
      product_model = Product.find_by_code(code)

      return nil if product_model.nil?

      ProductEntity.new(
        product_model.code,
        product_model.name,
        product_model.price
      )
    end
  end
end
