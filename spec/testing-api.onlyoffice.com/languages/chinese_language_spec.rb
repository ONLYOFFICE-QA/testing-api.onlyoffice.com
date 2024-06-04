# frozen_string_literal: true

require 'spec_helper'

describe 'chinese_language' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: 'Chinese Language docs', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @api_page = @instance.go_to_main_page
    @chinese_page = @api_page.change_language('zh')
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'Chinese language page should load onlyoffice editors basic page' do
    expect(@chinese_page).to be_a(TestingApiOnlyOfficeCom::DocsApiPage)
  end

  it 'Chinese language page should have some chinese text' do
    expect(@chinese_page).to be_with_chinese_text
  end
end
