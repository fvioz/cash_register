# frozen_string_literal: true
# typed: tur

require 'spec_helper'

RSpec.describe Products::Product, type: :model do
  subject(:model) { described_class }

  describe '.all' do
    it { expect(model.all).to be_an_instance_of(Array) }
  end

  describe '.find_by_code' do
    it { expect(model.find_by_code('GR1')).not_to be_nil }
    it { expect(model.find_by_code('GR2')).to be_nil }

    describe 'returned product' do
      subject(:product) { model.find_by_code('GR1') }

      it { expect(product.code).to eq('GR1') }
      it { expect(product.name).to eq('Green tea') }
      it { expect(product.price).to eq(BigDecimal('3.11')) }
    end
  end
end
