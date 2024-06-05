# frozen_string_literal: true

require 'spec_helper'

describe 'site_api_tests' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: 'Site Api', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @main_page = @instance.go_to_main_page
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  describe '[Docs] Try now' do
    before do
      @docs_api = @main_page.go_to_docs_api
    end

    it 'try now works (editor)' do
      expect(@docs_api).to be_try_now_works
    end
  end
end
