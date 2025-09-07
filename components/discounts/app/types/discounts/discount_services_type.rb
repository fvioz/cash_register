# frozen_string_literal: true
# typed: strict

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
