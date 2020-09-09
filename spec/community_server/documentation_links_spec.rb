# frozen_string_literal: true

require 'spec_helper'
describe 'community_server_documentation' do
  test_manager = TestingApiOnlyfficeCom::TestManager.new(suite_name: 'Community Server Documentation Links', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyfficeCom::TestInstance.new(config)
    @api_page = @instance.go_to_main_page
  end

  describe 'document_builder_documentation_links' do
    before do
      @api_community_server_page = @api_page.go_to_community_server_api
    end

    after do |example|
      test_manager.add_result(example)
      @instance.webdriver.quit
    end

    it 'check all links in documentation are visible' do
      result, failed = @api_community_server_page.community_server_links_ok?
      expect(result).to be_truthy, "Page #{@instance.webdriver.driver.current_url}\n\nNot found api links: #{failed}"
    end
  end
end
