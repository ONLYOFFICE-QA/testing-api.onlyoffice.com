require 'bundler/setup'
require 'palladium'
require 'onlyoffice_tcm_helper'
require 'ooxml_parser'
require_relative '../lib/testing_api_onlyoffice_com'

RSpec.configure do |config|
  config.before :all do
    @config = TestingApiOnlyfficeCom::Config.new
  end
end
