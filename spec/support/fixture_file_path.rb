# frozen_string_literal: true

# See https://relishapp.com/rspec/rspec-rails/docs/file-fixture

# require "active_support/testing/file_fixtures"

# module RSpec
#   module Rails
#     # @private
#     module FileFixtureSupport
#       extend ActiveSupport::Concern
#       include ActiveSupport::Testing::FileFixtures

#       included do
#         self.file_fixture_path = RSpec.configuration.file_fixture_path
#       end
#     end
#   end
# end

module Pipedriveable::Testing
  module FileFixtureHelper
    def fixture_file_path(*paths)
      File.join("spec/fixtures/files", *paths)
    end
  end
end

RSpec.configure do |config|
  config.include Pipedriveable::Testing::FileFixtureHelper
end