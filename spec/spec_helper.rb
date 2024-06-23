require "debug"

if RSpec.configuration.files_to_run.size > 1
  require "simplecov"
  SimpleCov.start do
    add_group "Lib", "lib"

    add_filter "/spec/"
    coverage_dir "tmp/coverage"
  end
end

# the lib should be required after SimpleCov starts
require "checkout"

# See https://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.order = :random
end
