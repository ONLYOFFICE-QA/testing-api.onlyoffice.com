require 'json'
require 'nokogiri'
require 'onlyoffice_file_helper'
require 'spec_helper'
describe 'document_builder_documentation_content' do
  before :all do
    @test_manager = TestingApiOnlyfficeCom::TestManager.new(suite_name: 'Document Builder Documentation Links Content', plan_name: @config.to_s)
  end

  path_to_json = File.expand_path('../../lib/testing_api_onlyoffice_com/test_instance/main_page/document_builder_api/document_builder_api_common/document_entries.json', __dir__)
  menu_data = JSON.parse(File.read(path_to_json))
  menu_data.each_pair do |editor, _method_array|
    context "#{editor} links content" do
      menu_data[editor].each_pair do |current_class, method_array|
        it "#{editor}/#{current_class}" do
          failed_methods = {}
          method_array.each do |method|
            link = "http://api.teamlab.info/docbuilder/#{editor.downcase.tr_s(' ', '')}/#{current_class.downcase.tr_s(' ', '')}/#{method.downcase.tr_s(' ', '')}"
            page = Nokogiri::HTML(URI.parse(link).open)
            params_exist = !page.xpath('//*[@class="table"]').empty?
            return_exist = !page.xpath('//*[@class="param-type"]').empty?
            example_exist = !page.xpath('//*[@class=" hljs cs"]').empty?
            document_exist = !page.xpath('//*[@class="docbuilder_resulting_docs"]').empty?
            next if params_exist && return_exist && example_exist && example_exist && document_exist

            not_added_element_array = []
            not_added_element_array << 'Parameters' unless params_exist
            not_added_element_array << 'Returns' unless return_exist
            not_added_element_array << 'Example' unless example_exist
            not_added_element_array << 'Resulting Document' unless document_exist

            failed_methods[link] = not_added_element_array
          end
          expect(failed_methods).to be_empty, "Array of failed methods: #{failed_methods}"
        end
      end
    end
  end

  after :each do |example|
    @test_manager.add_result(example)
  end
end
