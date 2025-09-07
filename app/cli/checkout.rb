# frozen_string_literal: true
# typed: false

require 'cli/ui'

module Cli
  class Checkout < Thor
    def self.exit_on_failure?
      true
    end

    desc 'scan BASKET_ITEMS', 'Product code name separated by comma without spaces i.e GR1,SR1,CF1'
    def scan(basket_items)
      Commands::Scan.new(basket_items.split(',')).call
    end

    desc 'version', 'Show application version'
    def version
      Commands::Version.call
    end
  end
end
