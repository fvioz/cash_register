# frozen_string_literal: true
# typed: strict

require 'bigdecimal'
require 'bigdecimal/util'

module Discounts
  class Discount
    Model = Struct.new(:product_code, :discount_type, :args)

    class << self
      extend T::Sig

      # In a real application, this would fetch data from a database.
      # Here, we hardcode some discounts for demonstration purposes.
      sig { returns(T::Array[Model]) }
      def all
        [
          Model.new('GR1', 'FreeItemDiscount', {}),
          Model.new('SR1', 'BulkDiscount', { threshold: 3, unit_price: BigDecimal('4.50') }),
          Model.new('CF1', 'PercentageDiscount', { threshold: 3, percentage: (1 - Rational(2, 3).to_d(10)) * 100 })
        ].freeze
      end

      sig { params(code: String).returns(T.untyped) }
      def find_by_product_code(code)
        all.find { |rule| rule.product_code == code }
      end
    end
  end
end
