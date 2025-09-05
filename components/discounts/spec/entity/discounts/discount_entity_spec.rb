# frozen_string_literal: true
# typed: false

require 'spec_helper'

RSpec.describe Discounts::DiscountEntity, type: :entity do
  subject(:entity) { described_class.new(total_price, total_discount) }

  let(:total_price) { BigDecimal('1.11') }
  let(:total_discount) { BigDecimal('3.33') }

  describe '#initialize' do
    it { is_expected.to be_a(described_class) }

    it { is_expected.to respond_to(:total_price) }
    it { is_expected.to respond_to(:total_discount) }

    it { expect(entity.total_price).to eq(BigDecimal('1.11')) }
    it { expect(entity.total_discount).to eq(BigDecimal('3.33')) }
  end

  describe 'attribute readers' do
    it { expect(entity.total_price).to eq(total_price) }
    it { expect(entity.total_discount).to eq(total_discount) }
  end
end
