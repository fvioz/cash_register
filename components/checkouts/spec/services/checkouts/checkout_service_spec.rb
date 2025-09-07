# frozen_string_literal: true
# typed: false

require 'spec_helper'

RSpec.describe Checkouts::CheckoutService, type: :service do
  subject(:service) { described_class.new(pricing_rules) }

  let(:pricing_rules) { Discounts::PricingRulesService.new }

  describe '#scan' do
    context 'when product exists' do
      before { service.scan('GR1') }

      it { expect(service.cart.size).to eq(1) }
      it { expect(service.cart.first.product.code).to eq('GR1') }
      it { expect(service.cart.first.quantity).to eq(1) }
    end

    context 'when product does not exist' do
      it 'raises an error' do
        expect do
          service.scan('INVALID_CODE')
        end.to raise_error(StandardError, 'Product with code INVALID_CODE not found.')
      end
    end
  end

  describe '#total' do
    before do
      service.scan('GR1') # 3.11
      service.scan('SR1') # 5.00
      service.scan('CF1') # 11.23
    end

    it { expect(service.total).to eq(BigDecimal('19.34')) }
  end

  describe '#original_total' do
    before do
      service.scan('GR1') # 3.11
      service.scan('SR1') # 5.00
      service.scan('CF1') # 11.23
    end

    it { expect(service.original_total).to eq(BigDecimal('19.34')) }
  end

  describe '#discount' do
    before do
      service.scan('GR1') # 3.11
      service.scan('GR1') # 3.11
    end

    it { expect(service.total).to eq(BigDecimal('3.11')) }
    it { expect(service.original_total).to eq(BigDecimal('6.22')) }
    it { expect(service.discount).to eq(BigDecimal('3.11')) }
  end
end
