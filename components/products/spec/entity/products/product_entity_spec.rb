# frozen_string_literal: true
# typed: false

require 'spec_helper'

RSpec.describe Products::ProductEntity, type: :entity do
  subject(:entity) { described_class.new(code, name, price) }

  let(:code) { 'GR1' }
  let(:name) { 'Green tea' }
  let(:price) { BigDecimal('3.11') }

  describe '#initialize' do
    it { is_expected.to be_a(described_class) }

    it { is_expected.to respond_to(:code) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:price) }

    it { expect(entity.code).to eq('GR1') }
    it { expect(entity.name).to eq('Green tea') }
    it { expect(entity.price).to eq(BigDecimal('3.11')) }
  end

  describe 'attribute readers' do
    it { expect(entity.code).to eq(code) }
    it { expect(entity.name).to eq(name) }
    it { expect(entity.price).to eq(price) }
  end
end
