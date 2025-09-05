# frozen_string_literal: true
# typed: true

module Cli
  module Commands
    class Version
      extend T::Sig

      sig { void }
      def self.call
        puts "Cash Register version #{Application.version}"
      end
    end
  end
end
