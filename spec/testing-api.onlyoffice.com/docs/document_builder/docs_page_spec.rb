# frozen_string_literal: true

require 'spec_helper'
describe 'docs_page' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: 'Docs Start Page', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @main_page = @instance.go_to_main_page
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  describe 'checked_getting_started_links' do
    before do
      @docs_page = @main_page.go_to_docs
    end

    it 'layout_table_footer_links_element_visible?' do
      @docs_page.footer_links.each do |key, value|
        expect(value).to be_truthy, "#{key}: non visible"
      end
    end

    it 'layout_table_footer_links_succeeded?' do
      @docs_page.survey_of_external_links.each do |key, value|
        expect(value.to_i < 400).to be_truthy, "#{key}: have client error responses code"
      end
    end
  end
end
