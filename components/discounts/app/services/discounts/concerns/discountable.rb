# frozen_string_literal: true
# typed: strict

module Discounts
  module Concerns
    module Discountable
      extend T::Sig
      extend T::Helpers

      include Kernel

      interface!

      sig { abstract.params(price: BigDecimal, quantity: Integer).returns(DiscountEntity) }
      def calculate(price, quantity); end
    end
  end
end
