# frozen_string_literal: true

require 'spec_helper'
describe 'document_builder_getting_started' do
  before :all do
    @test_manager = TestingApiOnlyfficeCom::TestManager.new(suite_name: 'Document Builder Getting Started', plan_name: config.to_s)
  end

  before :each do
    @instance = TestingApiOnlyfficeCom::TestInstance.new(config)
    @api_page = @instance.go_to_main_page
  end

  describe 'download_libraries' do
    before :each do
      introduction_page = @api_page.go_to_document_builder_introduction
      @getting_started_page = introduction_page.open_getting_started
    end

    it 'download library for LINUXx64 works' do
      result, file_size_linux_x64 = @getting_started_page.download_library_linux_x64_works?
      expect(result).to be_truthy, "Page #{@instance.webdriver.driver.current_url}\n\nFile size: #{file_size_linux_x64}"
    end

    it 'download library for WINDOWSx64 works' do
      result, file_size_windows_x64 = @getting_started_page.download_library_windows_x64_works?
      expect(result).to be_truthy, "Page #{@instance.webdriver.driver.current_url}\n\nFile size: #{file_size_windows_x64}"
    end

    it 'download library for WINDOWSx86 works' do
      result, file_size_windows_x86 = @getting_started_page.download_library_windows_x86_works?
      expect(result).to be_truthy, "Page #{@instance.webdriver.driver.current_url}\n\nFile size: #{file_size_windows_x86}"
    end
  end

  after :each do |example|
    @test_manager.add_result(example)
    @instance.webdriver.quit
  end
end
