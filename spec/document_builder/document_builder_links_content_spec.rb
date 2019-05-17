require 'json'
require 'nokogiri'
require 'onlyoffice_file_helper'
require 'spec_helper'
require_relative '../../lib/testing_api_onlyoffice_com/test_instance/main_page/document_builder_api/documentation_method_page'
describe 'document_builder_documentation_content' do
  before :all do
    @test_manager = TestingApiOnlyfficeCom::TestManager.new(suite_name: 'Document Builder Documentation Links Content', plan_name: @config.to_s)
  end

  TestingApiOnlyfficeCom::BuilderPage.parse_document_entries.each_pair do |editor, class_array|
    context "#{editor} links content" do
      class_array.each_pair do |current_class, method_array|
        it "#{editor}/#{current_class}" do
          failed_methods = {}
          method_array.each do |method|
            page = TestingApiOnlyfficeCom::DocumentationMethodPage.new(editor, current_class, method)
            next if page.all_elements_exist?

            failed_methods[page.link] = page.not_existed_elements
          end
          expect(failed_methods).to be_nil, "Array of failed methods: #{failed_methods}"
        end
      end
    end
  end

  after :each do |example|
    @test_manager.add_result(example)
  end
end
