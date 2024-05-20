# frozen_string_literal: true

require 'spec_helper'
describe 'docspace_documentation' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: 'DocSpace Documentation Links', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @api_page = @instance.go_to_main_page
  end

  describe 'docspace_documentation_links' do
    before do
      @api_docspace_page = @api_page.go_to_docspace_backend
    end

    after do |example|
      test_manager.add_result(example)
      @instance.webdriver.quit
    end

    it 'check API BACKEND in documentation are visible' do
      result, failed = @api_docspace_page.backend_links_ok?
      expect(result).to be_truthy, "Page #{@instance.webdriver.driver.current_url}\n\nNot found api links: #{failed}"
    end
  end
end
