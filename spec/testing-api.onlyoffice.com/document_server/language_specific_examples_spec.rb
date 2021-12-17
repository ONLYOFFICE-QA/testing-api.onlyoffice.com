# frozen_string_literal: true

require 'spec_helper'

describe 'language_specific_examples' do
  test_manager = TestingApiOnlyfficeCom::TestManager.new(suite_name: 'DocumentServer Language Specific Examples', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyfficeCom::TestInstance.new(config)
    @examples_page = @instance.go_to_main_page
                              .go_to_document_server_api
                              .go_to_integration_examples
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'Examples count is the same as stored in data' do
    expect(@examples_page.examples_count).to eq(DocumentServerAPI::DOC_SERVER_EXAMPLES.count)
  end

  describe 'Check all examples' do
    DocumentServerAPI::DOC_SERVER_EXAMPLES.each do |language|
      it "#{language} example visibility" do
        expect(@examples_page).to be_example_visible(language)
      end

      it "#{language} example downloadability" do
        expect(@examples_page).to be_example_downloadable(language)
      end
    end
  end
end
