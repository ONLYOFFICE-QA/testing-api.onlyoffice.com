# frozen_string_literal: true

require 'spec_helper'

describe 'document_builder_documentation' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: 'Document Builder Documentation Links', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @docs = @instance.go_to_main_page
                     .go_to_docs
  end

  describe 'document_builder_documentation_links' do
    before do
      @office_api = @docs.go_to_office_api
    end

    after do |example|
      test_manager.add_result(example)
      @instance.webdriver.quit
    end

    it 'check all links in documentation are visible' do
      result, failed = @office_api.document_builder_links_ok?
      expect(result).to be_truthy, "Page #{@instance.webdriver.driver.current_url}\n\nNot found api links: #{failed}"
    end
  end
end
