# frozen_string_literal: true
# typed: strict

module Products
  class Product
    Model = Struct.new(:code, :name, :price)

    class << self
      extend T::Sig

      # In a real application, this would fetch data from a database.
      # Here, we hardcode some products for demonstration purposes.
      sig { returns(T::Array[Model]) }
      def all
        [
          Model.new('GR1', 'Green tea', BigDecimal('3.11')),
          Model.new('SR1', 'Strawberries', BigDecimal('5.00')),
          Model.new('CF1', 'Coffee', BigDecimal('11.23'))
        ].freeze
      end

      sig { params(code: String).returns(T.nilable(Model)) }
      def find_by_code(code)
        all.find { |product| product.code == code }
      end
    end
  end
end
