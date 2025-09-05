# frozen_string_literal: true
# typed: false

RSpec.describe Discounts::PricingRulesService, type: :service do
  subject(:service) { described_class.new }

  describe '#find_by_product_code' do
    let(:result) { service.find_by_product_code(code) }

    context 'when no existent discount' do
      let(:code) { 'WRONG_CODE' }

      it { expect(result).to be_an_instance_of(Discounts::NoDiscountService) }
    end

    context 'when product has discount but is not mapped' do
      let(:code) { 'UNMAPPED' }

      before do
        allow(Discounts::Discount).to receive(:find_by_product_code).with(code).and_return(
          Discounts::Discount::Model.new(code, 'UnmappedDiscount', {})
        )
      end

      it { expect { result }.to output(/Unsupported discount type: UnmappedDiscount/).to_stdout }
    end

    context 'when product has a BulkDiscount discount' do
      let(:code) { 'SR1' }

      it { expect(result).to be_an_instance_of(Discounts::BulkDiscountService) }
    end

    context 'when product has a FreeItemDiscount discount' do
      let(:code) { 'GR1' }

      it { expect(result).to be_an_instance_of(Discounts::FreeItemDiscountService) }
    end

    context 'when product has a PercentageDiscount discount' do
      let(:code) { 'CF1' }

      it { expect(result).to be_an_instance_of(Discounts::PercentageDiscountService) }
    end
  end
end
