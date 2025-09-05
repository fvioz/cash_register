# frozen_string_literal: true
# typed: true

module Discounts
  class PercentageDiscountService
    extend T::Sig

    include Concerns::Discountable

    PercentageType = T.type_alias { T.any(Integer, Float, BigDecimal) }

    sig { params(threshold: Integer, percentage: PercentageType).void }
    def initialize(threshold, percentage)
      super()
      @threshold = threshold
      @percentage = percentage

      return unless @percentage.negative? || @percentage > 100

      raise ArgumentError, 'Percentage must be between 0 and 100'
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

      (price - ((price * @percentage) / 100)) * quantity
    end
  end
end
