# frozen_string_literal: true

require 'bundler/setup'
require_relative '../lib/testing_api_onlyoffice_com'
require_relative 'shared_examples_for_docspace_spec'
require_relative 'shared_examples_for_workspace_spec'
require_relative 'shared_examples_for_docbuilder_spec'

include TestingApiOnlyOfficeCom

# @return [TestingApiOnlyOfficeCom::Config] config of test run
def config
  @config ||= TestingApiOnlyOfficeCom::Config.new
end
