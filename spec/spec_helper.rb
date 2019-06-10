# frozen_string_literal: true

require 'bundler/setup'
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
      pending('https://github.com/ONLYOFFICE/api.onlyoffice.com/issues/49') if failed_docbuilder_tests.include?("#{path}/Parameters")
      pending('https://github.com/ONLYOFFICE/api.onlyoffice.com/issues/54') if failed_community_server_tests.include?("#{path}/Parameters")
      expect(@documentation_page.params_exist).to be_truthy
    end

    it "#{path}/Returns" do
      pending 'https://github.com/ONLYOFFICE/api.onlyoffice.com/issues/49' if failed_docbuilder_tests.include?("#{path}/Returns")
      pending 'https://github.com/ONLYOFFICE/api.onlyoffice.com/issues/54' if failed_community_server_tests.include?("#{path}/Returns")
      expect(@documentation_page.return_exist).to be_truthy
    end

    it "#{path}/Example" do
      pending 'https://github.com/ONLYOFFICE/api.onlyoffice.com/issues/49' if failed_docbuilder_tests.include?("#{path}/Example")
      pending 'https://github.com/ONLYOFFICE/api.onlyoffice.com/issues/54' if failed_community_server_tests.include?("#{path}/Example")
      expect(@documentation_page.example_exist).to be_truthy
    end

    it "#{path}/Resulting document" do
      pending 'https://github.com/ONLYOFFICE/api.onlyoffice.com/issues/49' if failed_docbuilder_tests.include?("#{path}/Resulting document")
      pending 'https://github.com/ONLYOFFICE/api.onlyoffice.com/issues/54' if failed_community_server_tests.include?("#{path}/Resulting document")
      expect(@documentation_page.document_exist).to be_truthy
    end
  end
end

def failed_docbuilder_tests
  @failed_docbuilder_tests ||= File.read("#{__dir__}/failed_docbuilder_tests")
end

def failed_community_server_tests
  @failed_community_server_tests ||= File.read("#{__dir__}/failed_community_server_tests")
end
