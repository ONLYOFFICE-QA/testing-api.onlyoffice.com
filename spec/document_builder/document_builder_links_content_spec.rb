require 'json'
require 'nokogiri'
require 'onlyoffice_file_helper'
require 'spec_helper'
require_relative '../../lib/testing_api_onlyoffice_com/test_instance/main_page/document_builder_api/documentation_method_page'
describe 'document_builder_documentation_content' do
  before :all do
    @test_manager = TestingApiOnlyfficeCom::TestManager.new(suite_name: 'Document Builder Documentation Links Content', plan_name: @config.to_s)
  end

  TestingApiOnlyfficeCom::BuilderPage.parse_document_entries.each_pair do |editor, class_hash|
    class_hash.each_pair do |current_class, method_array|
      method_array.each do |method|
        context "#{editor}/#{current_class}/#{method}" do
          page = TestingApiOnlyfficeCom::DocumentationMethodPage.new(editor, current_class, method)
          it_behaves_like 'page_content_exist', page
        end
      end
    end
  end

  after :each do |example|
    @test_manager.add_result(example)
  end
end
