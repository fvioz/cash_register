# frozen_string_literal: true
# typed: true

module Discounts
  class DiscountEntity
    extend T::Sig

    attr_reader :total_price, :total_discount

    sig { params(total_price: BigDecimal, total_discount: BigDecimal).void }
    def initialize(total_price, total_discount)
      @total_price = total_price
      @total_discount = total_discount
    end
  end
end
