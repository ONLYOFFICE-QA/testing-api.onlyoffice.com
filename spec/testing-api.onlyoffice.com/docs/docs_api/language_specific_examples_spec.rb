# frozen_string_literal: true

require 'spec_helper'

describe '[Docs] language_specific_examples' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: 'DocumentServer Language Specific Examples', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @examples_page = @instance.go_to_main_page
                              .go_to_docs_api
                              .go_to_language_specific_examples
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it '[Docs] Examples count is the same as stored in data' do
    expect(@examples_page.examples_count).to eq(TestData::DOC_SERVER_EXAMPLES.count)
  end

  describe 'Check all examples' do
    TestData::DOC_SERVER_EXAMPLES.each do |language|
      it "#{language} example visibility" do
        expect(@examples_page).to be_example_visible(language)
      end

      it "#{language} example downloadability" do
        expect(@examples_page).to be_example_downloadable(language)
      end
    end
  end
end

describe '[Docs] Demo preview' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: 'Site Api', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @main_page = @instance.go_to_main_page
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  describe 'Demo preview tabs' do
    before do
      @docs_api = @main_page.go_to_docs_api
    end

    it '[Docs] demo `document` editor works' do
      expect(@docs_api).to be_integration_example_work(:document)
    end

    it '[Docs] demo `spreadsheet` editor works' do
      expect(@docs_api).to be_integration_example_work(:spreadsheet)
    end

    it '[Docs] demo `presentation` editor works' do
      expect(@docs_api).to be_integration_example_work(:presentation)
    end
  end
end
