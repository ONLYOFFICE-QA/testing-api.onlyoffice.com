# frozen_string_literal: true

require 'spec_helper'

describe 'site_api_tests' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: 'Site Api', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @api_page = @instance.go_to_main_page
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  describe '#document_builder' do
    before do
      @introduction_page = @api_page.go_to_document_builder_introduction
    end

    it '[API][DocumentBuilder] generate document works' do
      result, file_size = @introduction_page.builder_works?
      expect(result).to be_truthy, "Page #{@instance.webdriver.driver.current_url}\n\nFile size: #{file_size}"
    end
  end

  describe '#document_server' do
    api_document_server_page = nil
    before { api_document_server_page = @api_page.go_to_document_server_api }

    it '[API][DocumentServer] try now works (editor)' do
      expect(api_document_server_page).to be_try_now_works
    end

    describe '#demo_editors' do
      it '[API][DocumentServer] demo `document` editor works' do
        expect(api_document_server_page).to be_integration_example_work(:document)
      end

      it '[API][DocumentServer] demo `spreadsheet` editor works' do
        expect(api_document_server_page).to be_integration_example_work(:spreadsheet)
      end

      it '[API][DocumentServer] demo `presentation` editor works' do
        expect(api_document_server_page).to be_integration_example_work(:presentation)
      end
    end
  end
end
