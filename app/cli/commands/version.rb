# frozen_string_literal: true
# typed: strict

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
