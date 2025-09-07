# frozen_string_literal: true
# typed: true

module Checkouts
  class CheckoutService
    extend T::Sig

    attr_reader :cart

    sig { params(pricing_rules: Discounts::PricingRulesService).void }
    def initialize(pricing_rules)
      @pricing_rules = pricing_rules
      @cart = T.let([], T::Array[CheckoutItemService])
    end

    sig { params(code: String, quantity: Integer).void }
    def scan(code, quantity = 1)
      product = Products::ProductService.find_by_code(code)

      raise "Product with code #{code} not found." if product.nil?

      existing_item = @cart.find { |item| item.product.code == code }

      if existing_item
        existing_item.quantity += quantity
      else
        checkout_item = CheckoutItemService.new(product, quantity, @pricing_rules)
        @cart << checkout_item
      end
    end

    sig { returns(T.any(Integer, BigDecimal)) }
    def total
      @cart.sum(&:total_price)
    end

    sig { returns(T.any(Integer, BigDecimal)) }
    def original_total
      @cart.sum(&:original_total_price)
    end

    def discount
      @cart.sum(&:total_discount)
    end
  end
end
