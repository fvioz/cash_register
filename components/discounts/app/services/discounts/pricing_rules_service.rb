# frozen_string_literal: true
# typed: true

require 'bigdecimal'
require 'bigdecimal/util'

module Discounts
  class PricingRulesService
    extend T::Sig

    # Extract to a service object if the list of pricing rules grows
    sig { params(code: String).returns(DiscountServicesType) }
    def find_by_product_code(code)
      pricing_rule = Discount.find_by_product_code(code)

      return NoDiscountService.new if pricing_rule.nil?

      discount_service_for(pricing_rule)
    end

    private

    # rubocop: disable Metrics/MethodLength
    def discount_service_for(pricing_rule)
      case pricing_rule.discount_type
      when 'FreeItemDiscount'
        FreeItemDiscountService.new
      when 'BulkDiscount'
        BulkDiscountService.new(pricing_rule.args[:threshold], pricing_rule.args[:unit_price])
      when 'PercentageDiscount'
        PercentageDiscountService.new(pricing_rule.args[:threshold], pricing_rule.args[:percentage])
      else
        puts "Unsupported discount type: #{pricing_rule.discount_type}"
        NoDiscountService.new
      end
    end
    # rubocop: enable Metrics/MethodLength
  end
end
