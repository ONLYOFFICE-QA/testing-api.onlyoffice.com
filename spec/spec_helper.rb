require 'bundler/setup'
require 'palladium'
require 'onlyoffice_tcm_helper'
require_relative '../lib/testing_api_onlyoffice_com'
include TestingApiOnlyfficeCom

RSpec.configure do |config|
  config.before :all do
    @config = TestingApiOnlyfficeCom::Config.new
  end
end
