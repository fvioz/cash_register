# frozen_string_literal: true
# typed: true

module Checkouts
  class CheckoutItemService
    extend T::Sig

    attr_accessor :quantity
    attr_reader :product

    sig do
      params(
        product: Products::ProductEntity,
        quantity: Integer,
        pricing_rules: Discounts::PricingRulesService
      ).void
    end
    def initialize(product, quantity, pricing_rules)
      @product = product
      @quantity = quantity
      @pricing_rules = pricing_rules
    end

    sig { returns(BigDecimal) }
    def total_price
      discount_calculation.total_price
    end

    sig { returns(BigDecimal) }
    def total_discount
      discount_calculation.total_discount
    end

    sig { returns(BigDecimal) }
    def original_total_price
      @product.price * @quantity
    end

    private

    sig { returns(Discounts::DiscountEntity) }
    def discount_calculation
      discount = @pricing_rules.find_by_product_code(@product.code)

      discount.calculate(@product.price, @quantity)
    end
  end
end
