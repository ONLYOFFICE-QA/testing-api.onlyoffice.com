require 'spec_helper'
describe 'document_builder_documentation' do
  before :all do
    @test_manager = TestingApiOnlyfficeCom::TestManager.new(suite_name: 'Document Builder Documentation Links', plan_name: @config.to_s)
  end

  before :each do
    @instance = TestingApiOnlyfficeCom::TestInstance.new(@config)
    @api_page = @instance.go_to_main_page
  end

  describe 'document_builder_documentation_links' do
    before :each do
      @introduction_page = @api_page.go_to_document_builder_introduction
    end

    it 'check links in documentation are visible' do
      result, failed = @introduction_page.document_builder_links_ok?
      expect(result).to be_truthy, "Page #{@instance.webdriver.driver.current_url}\n\nNot found api links: #{failed}"
    end

    after :each do |example|
      @test_manager.add_result(example)
      @instance.webdriver.quit
    end
  end
end
