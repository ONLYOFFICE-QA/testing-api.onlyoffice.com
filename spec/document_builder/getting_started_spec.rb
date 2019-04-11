require 'spec_helper'
describe 'document_builder_getting_started' do
  before :all do
    @test_manager = TestingApiOnlyfficeCom::TestManager.new(suite_name: 'Document Builder Getting Started', plan_name: @config.to_s)
  end

  before :each do
    @instance = TestingApiOnlyfficeCom::TestInstance.new(@config)
    @api_page = @instance.go_to_main_page
  end

  describe 'download_libraries' do
    before :each do
      @introduction_page = @api_page.go_to_document_builder_introduction
      @getting_started_page = @introduction_page.open_getting_started
    end

    it 'download library for LINUXx64 works' do
      result, file_size_linuxx64 = @getting_started_page.download_library_linuxx64_works?
      expect(result).to be_truthy, "Page #{@instance.webdriver.driver.current_url}\n\nFile size: #{file_size_linuxx64}"
    end

    it 'download library for WINDOWSx64 works' do
      result, file_size_windowsx64 = @getting_started_page.download_library_windowsx64_works?
      expect(result).to be_truthy, "Page #{@instance.webdriver.driver.current_url}\n\nFile size: #{file_size_windowsx64}"
    end

    it 'download library for WINDOWSx86 works' do
      result, file_size_windowsx86 = @getting_started_page.download_library_windowsx86_works?
      expect(result).to be_truthy, "Page #{@instance.webdriver.driver.current_url}\n\nFile size: #{file_size_windowsx86}"
    end
  end

  after :each do |example|
    @test_manager.add_result(example)
    @instance.webdriver.quit
  end
end
