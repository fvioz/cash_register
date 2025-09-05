# frozen_string_literal: true
# typed: true

module Products
  class ProductEntity
    extend T::Sig

    attr_reader :code, :name, :price

    sig { params(code: String, name: String, price: BigDecimal).void }
    def initialize(code, name, price)
      @code = code
      @name = name
      @price = price
    end
  end
end
