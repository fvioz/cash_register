# frozen_string_literal: true
# typed: true

module Discounts
  DiscountServicesType = T.type_alias do
    T.any(
      NoDiscountService,
      BulkDiscountService,
      FreeItemDiscountService,
      PercentageDiscountService
    )
  end
end
