# frozen_string_literal: true
# typed: true

module Discounts
  class FreeItemDiscountService
    extend T::Sig

    include Concerns::Discountable

    sig { override.params(price: BigDecimal, quantity: Integer).returns(DiscountCalculationType) }
    def calculate(price, quantity)
      total_price = total_price(price, quantity)

      {
        total_discount: (price * quantity) - total_price,
        total_price: total_price
      }
    end

    private

    sig { params(price: BigDecimal, quantity: Integer).returns(BigDecimal) }
    def total_price(price, quantity)
      if quantity.odd?
        price * ((quantity / 2) + 1)
      else
        price * (quantity / 2)
      end
    end
  end
end
