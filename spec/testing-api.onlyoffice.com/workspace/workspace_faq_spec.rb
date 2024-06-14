# frozen_string_literal: true

require 'spec_helper'
describe 'workspace_faq_page' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: 'Workspace FAQ page', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    api_page = @instance.go_to_main_page
    @faq_page = api_page.go_to_workspace_api.go_to_faq
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'FAQ page correctly opened' do
    expect(@faq_page).to be_a(TestingApiOnlyOfficeCom::WorkspaceFaqPage)
  end
end
