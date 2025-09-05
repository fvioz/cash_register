# frozen_string_literal: true
# typed: true

module Discounts
  class NoDiscountService
    extend T::Sig

    include Concerns::Discountable

    sig { override.params(price: BigDecimal, quantity: Integer).returns(DiscountCalculationType) }
    def calculate(price, quantity)
      {
        total_discount: BigDecimal('0.0'),
        total_price: price * quantity
      }
    end
  end
end
