# frozen_string_literal: true

require 'spec_helper'
describe 'document_builder_getting_started' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: 'Document Builder Getting Started', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @api_page = @instance.go_to_main_page
  end

  after do |example|
    # test_manager.add_result(example)
    @instance.webdriver.quit
  end

  describe 'checked_getting_started_links' do
    before do
      introduction_page = @api_page.go_to_document_builder_introduction
      @getting_started_page = introduction_page.open_getting_started
    end

    it 'layout_table_footer_links_element_visible?' do
      @getting_started_page.footer_links.each do |key, value|
        expect(value).to be_truthy, "#{key}: non visible"
      end
    end

    it 'layout_table_footer_links_succeeded?' do
      @getting_started_page.survey_of_external_links.each do |key, value|
        expect(value.to_i < 400).to be_truthy, "#{key}: have client error responses code"
      end
    end
  end
end
