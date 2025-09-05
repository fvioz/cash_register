# frozen_string_literal: true
# typed: false

require 'spec_helper'

RSpec.describe Discounts::Discount, type: :model do
  subject(:model) { described_class }

  describe '.all' do
    it { expect(model.all).to be_an_instance_of(Array) }
  end

  describe '.find_by_product_code' do
    it { expect(model.find_by_product_code('GR1')).not_to be_nil }
    it { expect(model.find_by_product_code('GR2')).to be_nil }

    describe 'returned product' do
      subject(:product) { model.find_by_product_code('GR1') }

      it { expect(product.product_code).to eq('GR1') }
      it { expect(product.discount_type).to eq('FreeItemDiscount') }
      it { expect(product.args).to eq({}) }
    end
  end
end
