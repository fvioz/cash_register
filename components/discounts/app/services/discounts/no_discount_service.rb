# frozen_string_literal: true
# typed: strict

module Discounts
  class NoDiscountService
    extend T::Sig

    include Concerns::Discountable

    sig { override.params(price: BigDecimal, quantity: Integer).returns(DiscountEntity) }
    def calculate(price, quantity)
      DiscountEntity.new(
        price * quantity,
        BigDecimal('0.0')
      )
    end
  end
end
