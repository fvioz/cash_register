# frozen_string_literal: true
# typed: false

RSpec.describe Discounts::BulkDiscountService, type: :service do
  subject(:service) { described_class.new(threshold, unit_price) }

  let(:price) { BigDecimal(2) }
  let(:quantity) { 3 }
  let(:threshold) { 3 }
  let(:unit_price) { BigDecimal(1) }

  describe '#calculate' do
    context 'when quantity is 0' do
      let(:quantity) { 0 }
      let(:result) { service.calculate(price, quantity) }

      it 'returns zero total total price' do
        expect(result.total_price).to eq(BigDecimal(0))
      end

      it 'returns zero total discount' do
        expect(result.total_discount).to eq(BigDecimal(0))
      end
    end

    context 'when quantity does not exceed the threshold' do
      let(:quantity) { 2 }

      let(:result) { service.calculate(price, quantity) }

      it 'returns the correct total total price' do
        expect(result.total_price).to eq(BigDecimal(4))
      end

      it 'returns the correct total discount' do
        expect(result.total_discount).to eq(BigDecimal(0))
      end
    end

    context 'when quantity exceeds the threshold' do
      let(:quantity) { 3 }

      let(:result) { service.calculate(price, quantity) }

      it 'returns the correct total total price' do
        expect(result.total_price).to eq(BigDecimal(3))
      end

      it 'returns the correct total discount' do
        expect(result.total_discount).to eq(BigDecimal(3))
      end
    end
  end
end
