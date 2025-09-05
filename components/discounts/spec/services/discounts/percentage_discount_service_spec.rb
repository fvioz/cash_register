# frozen_string_literal: true
# typed: false

RSpec.describe Discounts::PercentageDiscountService, type: :service do
  subject(:service) { described_class.new(threshold, percentage) }

  let(:price) { BigDecimal(2) }
  let(:quantity) { 3 }
  let(:threshold) { 3 }
  let(:percentage) { 20 }

  describe '#calculate' do
    let(:result) { service.calculate(price, quantity) }

    context 'when percentage is out of range' do
      describe 'less than 0' do
        let(:percentage) { BigDecimal('-0.0000001') }

        it 'raises an error' do
          expect { service }.to raise_error(ArgumentError, 'Percentage must be between 0 and 100')
        end
      end

      describe 'bigger than 100' do
        let(:percentage) { BigDecimal('100.0000001') }

        it 'raises an error' do
          expect { service }.to raise_error(ArgumentError, 'Percentage must be between 0 and 100')
        end
      end
    end

    context 'when quantity is 0' do
      let(:quantity) { 0 }

      it 'returns zero total total price' do
        expect(result.total_price).to eq(BigDecimal(0))
      end

      it 'returns zero total discount' do
        expect(result.total_discount).to eq(BigDecimal(0))
      end
    end

    context 'when quantity does not exceed the threshold' do
      let(:quantity) { 2 }

      it 'returns the correct total total price' do
        expect(result.total_price).to eq(BigDecimal(4))
      end

      it 'returns the correct total discount' do
        expect(result.total_discount).to eq(BigDecimal(0))
      end
    end

    context 'when quantity exceeds the threshold' do
      let(:quantity) { 3 }

      it 'returns the correct total total price' do
        expect(result.total_price).to eq(BigDecimal('4.8'))
      end

      it 'returns the correct total discount' do
        expect(result.total_discount).to eq(BigDecimal('1.2'))
      end
    end
  end
end
