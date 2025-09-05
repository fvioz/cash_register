# frozen_string_literal: true
# typed: true

module Discounts
  module Concerns
    module Discountable
      extend T::Sig
      extend T::Helpers

      interface!

      sig { abstract.params(price: BigDecimal, quantity: Integer).returns(DiscountCalculationType) }
      def calculate(price, quantity); end
    end
  end
end
