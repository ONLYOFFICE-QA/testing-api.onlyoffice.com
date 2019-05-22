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
      expect(@documentation_page.params_exist).to be_truthy
    end

    it "#{path}/Returns" do
      expect(@documentation_page.return_exist).to be_truthy
    end

    it "#{path}/Example" do
      expect(@documentation_page.example_exist).to be_truthy
    end

    it "#{path}/Resulting document" do
      expect(@documentation_page.document_exist).to be_truthy
    end
  end
end
