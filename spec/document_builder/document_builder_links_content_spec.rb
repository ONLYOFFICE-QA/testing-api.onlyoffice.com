require 'spec_helper'
require 'minitest/autorun'
require 'json'
describe 'document_builder_documentation_content' do
  before :all do
    @test_manager = TestingApiOnlyfficeCom::TestManager.new(suite_name: 'Document Builder Documentation Links Content', plan_name: @config.to_s)
    @menu_data ||= JSON.parse(File.read("#{__dir__}/document_entries.json"))
  end

  @menu_data["Text document API"].each_pair do |current_class, method_array|
    it "#{current_class}" do
      failed_methods = []
      method_array.each do |method|
        link = "http://api.teamlab.info/docbuilder/textdocumentapi/#{current_class.downcase.tr_s(' ', '')}/#{method.downcase.tr_s(' ', '')}"
        page = Nokogiri::HTML(open(link))
        params_exist = !page.xpath('//*[@class="table"]').empty?
        return_exist = !page.xpath('//*[@class="param-type"]').empty?
        example_exist = !page.xpath('//*[@class="button copy-code"]').empty?
        document_exist = !page.xpath('//*[@class="docbuilder_resulting_docs"]').empty?
        if params_exist && return_exist && example_exist && example_exist && document_exist
          next
        end
        failed_methods << {"link": "#{link}", "Parameters": "#{params_exist}", "Returns": "#{return_exist}", "Example": "#{example_exist}", "Resulting Document": "#{document_exist}"}
      end
      expect(failed_methods).to be_empty, "Array of fail methods: #{failed_methods}"
    end
  end
  after :each do |example|
    @test_manager.add_result(example)
  end
end