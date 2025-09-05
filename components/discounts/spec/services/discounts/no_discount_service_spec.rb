# frozen_string_literal: true
# typed: false

RSpec.describe Discounts::NoDiscountService, type: :service do
  subject(:service) { described_class.new }

  let(:price) { BigDecimal(2) }
  let(:quantity) { 3 }

  describe '#calculate' do
    let(:calculate) { service.calculate(price, quantity) }

    context 'when quantity is 0' do
      let(:quantity) { 0 }

      it 'returns zero total total price' do
        expect(calculate[:total_price]).to eq(BigDecimal(0))
      end

      it 'returns zero total discount' do
        expect(calculate[:total_discount]).to eq(BigDecimal(0))
      end
    end

    context 'when quantity is different than zero' do
      let(:quantity) { 4 }

      it 'returns the correct total total price' do
        expect(calculate[:total_price]).to eq(BigDecimal(8))
      end

      it 'returns the correct total discount' do
        expect(calculate[:total_discount]).to eq(BigDecimal(0))
      end
    end
  end
end
