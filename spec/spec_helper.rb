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

shared_examples_for 'page_content_exist' do |path, documentation_page|
  describe 'element_include?' do
    before :all do
      @documentation_page = documentation_page.call
    end

    it "#{path}/Parameters" do
      pending('https://github.com/ONLYOFFICE/api.onlyoffice.com/issues/49') if File.read("#{__dir__}/failed_documentation_content_tests.txt").include?("#{path}/Parameters")
      expect(@documentation_page.params_exist).to be_truthy
    end

    it "#{path}/Returns" do
      pending 'https://github.com/ONLYOFFICE/api.onlyoffice.com/issues/49' if File.read("#{__dir__}/failed_documentation_content_tests.txt").include?("#{path}/Returns")
      expect(@documentation_page.return_exist).to be_truthy
    end

    it "#{path}/Example" do
      pending 'https://github.com/ONLYOFFICE/api.onlyoffice.com/issues/49' if File.read("#{__dir__}/failed_documentation_content_tests.txt").include?("#{path}/Example")
      expect(@documentation_page.example_exist).to be_truthy
    end

    it "#{path}/Resulting document" do
      pending 'https://github.com/ONLYOFFICE/api.onlyoffice.com/issues/49' if File.read("#{__dir__}/failed_documentation_content_tests.txt").include?("#{path}/Resulting document")
      expect(@documentation_page.document_exist).to be_truthy
    end
  end
end
