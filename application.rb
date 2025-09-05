# frozen_string_literal: true
# typed: false

require_relative 'boot'

require 'zeitwerk'
require 'packs'
require 'debug' if ENV['RUBY_ENV'] == 'development'

APP_VERSION = '1.0.0'

module Application
  LOAD_PATHS = %w[].freeze

  def self.initialize!
    zeitwerk_loader!

    root.glob('config/initializers/**/*.rb').sort_by(&:to_s).each { |f| require f }
  end

  def self.version
    APP_VERSION
  end

  def self.root
    Pathname.new(Dir.pwd)
  end

  def self.zeitwerk_loader!
    loader = Zeitwerk::Loader.new
    loader.tag = File.basename __FILE__, '.rb'

    zeitwerk_push_dirs!(loader)

    loader.enable_reloading if ENV['RUBY_ENV'] == 'development'
    loader.setup
  end

  def self.zeitwerk_push_dirs!(loader)
    LOAD_PATHS.each do |paths|
      root.glob(paths).sort_by(&:to_s).each do |path|
        loader.push_dir(root.join(path))
      end
    end
  end
end
