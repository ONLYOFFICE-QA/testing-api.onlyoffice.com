# frozen_string_literal: true

require 'spec_helper'
describe 'document_builder_getting_started' do
  test_manager = TestingApiOnlyfficeCom::TestManager.new(suite_name: 'Document Builder Getting Started', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyfficeCom::TestInstance.new(config)
    @api_page = @instance.go_to_main_page
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  describe 'checked_getting_started_links' do
    before do
      introduction_page = @api_page.go_to_document_builder_introduction
      @getting_started_page = introduction_page.open_getting_started
    end

    it 'external_docbuilder_links_succeeded?' do
      expect(@getting_started_page.external_links_succeeded?).to be_truthy, 'Links not available'
    end
  end
end
