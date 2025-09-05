# frozen_string_literal: true
# typed: false

require 'spec_helper'

RSpec.describe Products::ProductService, type: :model do
  subject(:services) { described_class }

  describe '.find_by_code' do
    it { expect(services.find_by_code('GR1')).to be_an_instance_of(Products::ProductEntity) }

    it { expect(services.find_by_code('GR1')).not_to be_nil }
    it { expect(services.find_by_code('GR2')).to be_nil }
  end
end
