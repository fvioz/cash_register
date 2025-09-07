# typed: false
# frozen_string_literal: true

require 'packs'

class PacksIntegration
  extend T::Sig

  def initialize
    if to_run == [default_path]
      # This is the default case when you run `rspec`. We want to add all the pack's spec paths
      # to the collection of directories to run.
      run_default_path
    else
      # This is when `rspec` is run with a list of directories or files. We scan this list to see
      # if any of them matches a pack's directory. If it does, we concat the `default_path` to the
      # end of it.
      #
      # packs/my_pack => packs/my_pack/spec
      #
      # If it doesn't match a pack path, we leave it alone.
      run_pack_paths
    end

    ::RSpec.configuration.files_or_directories_to_run = to_run.flatten.compact.uniq
  end

  def to_run
    # This is the list of directories RSpec was told to run.
    ::RSpec.configuration.instance_variable_get(:@files_or_directories_to_run)
  end

  def default_path
    ::RSpec.configuration.default_path
  end

  sig { params(parent_pack: ::Packs::Pack).returns(T::Array[::Packs::Pack]) }
  def nested_packs_for(parent_pack)
    ::Packs.all.select do |pack|
      pack.name != parent_pack.name && pack.name.include?(parent_pack.name)
    end
  end

  def run_default_path
    # This is the default case when you run `rspec`. We want to add all the pack's spec paths
    # to the collection of directories to run.

    pack_paths = ::Packs.all.map do |pack|
      next if pack.is_gem?

      spec_path = pack.relative_path.join(default_path)
      spec_path.to_s if spec_path.exist?
    end

    to_run.concat(pack_paths)
  end

  # rubocop:disable Metrics/MethodLength
  def run_pack_paths
    to_run.map! do |path|
      if (pack = ::Packs.find(path))
        [
          pack,
          *nested_packs_for(pack)
        ].map do |pack|
          spec_path = pack.relative_path.join(default_path)
          spec_path.to_s if spec_path.exist?
        end
      else
        path
      end
    end
  end
  # rubocop:enable Metrics/MethodLength
end

PacksIntegration.new
