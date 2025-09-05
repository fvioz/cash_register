# frozen_string_literal: true
# typed: true

module Discounts
  DiscountCalculationType = T.type_alias do
    {
      total_discount: BigDecimal,
      total_price: BigDecimal
    }
  end
end
