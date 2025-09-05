# frozen_string_literal: true
# typed: true

module Discounts
  class BulkDiscountService
    extend T::Sig

    include Concerns::Discountable

    sig { params(threshold: Integer, unit_price: BigDecimal).void }
    def initialize(threshold, unit_price)
      super()
      @threshold = threshold
      @unit_price = unit_price
    end

    sig { override.params(price: BigDecimal, quantity: Integer).returns(DiscountEntity) }
    def calculate(price, quantity)
      DiscountEntity.new(
        total_price(price, quantity),
        total_discount(price, quantity)
      )
    end

    private

    sig { params(quantity: Integer).returns(T::Boolean) }
    def exceeds_threshold?(quantity)
      quantity >= @threshold
    end

    sig { params(price: BigDecimal, quantity: Integer).returns(BigDecimal) }
    def total_discount(price, quantity)
      return BigDecimal('0.0') unless exceeds_threshold?(quantity)

      (price * quantity) - total_price(price, quantity)
    end

    sig { params(price: BigDecimal, quantity: Integer).returns(BigDecimal) }
    def total_price(price, quantity)
      return price * quantity unless exceeds_threshold?(quantity)

      @unit_price * quantity
    end
  end
end
