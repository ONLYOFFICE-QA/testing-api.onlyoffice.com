# frozen_string_literal: true

require 'spec_helper'

describe 'site_api_tests' do
  before :all do
    @test_manager = TestingApiOnlyfficeCom::TestManager.new(suite_name: 'Site Api', plan_name: @config.to_s)
  end

  before :each do
    @instance = TestingApiOnlyfficeCom::TestInstance.new(@config)
    @api_page = @instance.go_to_main_page
  end

  context '#document_builder' do
    before :each do
      @introduction_page = @api_page.go_to_document_builder_introduction
    end

    it '[API][DocumentBuilder] generate document works' do
      result, file_size = @introduction_page.builder_works?
      expect(result).to be_truthy, "Page #{@instance.webdriver.driver.current_url}\n\nFile size: #{file_size}"
    end

    it '[API][DocumentBuilder] Integrating Document Builder download links shown and alive' do
      integraing_page = @introduction_page.open_integrating_document_builder
      result, failed = integraing_page.download_links_ok?
      expect(result).to be_truthy, "Page #{@instance.webdriver.driver.current_url}\n\nBad mojo with document builder links:\n #{failed}"
    end
  end

  context '#document_server' do
    api_document_server_page = nil
    before { api_document_server_page = @api_page.go_to_document_server_api }

    it '[API][DocumentServer] try now works (editor)' do
      expect(api_document_server_page.try_now_works?).to be_truthy
    end

    it '[API][DocumentServer] integration examples download links shown and alive' do
      api_document_server_page.go_to_integration_examples
      result, failed = api_document_server_page.download_links_ok?
      expect(result).to be_truthy, "Page #{@instance.webdriver.driver.current_url}\n\nBad mojo with document server links:\n #{failed}"
    end

    context '#demo_editors' do
      it '[API][DocumentServer] demo `document` editor works' do
        expect(api_document_server_page.integration_example_work?(:document)).to be_truthy
      end

      it '[API][DocumentServer] demo `spreadsheet` editor works' do
        expect(api_document_server_page.integration_example_work?(:spreadsheet)).to be_truthy
      end

      it '[API][DocumentServer] demo `presentation` editor works' do
        expect(api_document_server_page.integration_example_work?(:presentation)).to be_truthy
      end
    end
  end

  after :each do |example|
    @test_manager.add_result(example)
    @instance.webdriver.quit
  end
end
