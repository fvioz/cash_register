# frozen_string_literal: true
# typed: false

require 'spec_helper'

RSpec.describe Checkouts::CheckoutItemService, type: :service do
  subject(:service) { described_class.new(product, 1, pricing_rules) }

  let(:product) { Products::ProductService.find_by_code('GR1') }
  let(:pricing_rules) { Discounts::PricingRulesService.new }

  describe '#total_price' do
    it { expect(service.total_price).to eq(BigDecimal('3.11')) }
  end

  describe '#total_discount' do
    it { expect(service.total_discount).to eq(BigDecimal(0)) }
  end

  describe '#original_total_price' do
    it { expect(service.original_total_price).to eq(BigDecimal('3.11')) }
  end
end
