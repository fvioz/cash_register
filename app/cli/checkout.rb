# frozen_string_literal: true
# typed: false

require 'cli/ui'

module Cli
  class Checkout < Thor
    def self.exit_on_failure?
      true
    end

    desc 'version', 'Show application version'
    def version
      Commands::Version.call
    end
  end
end
