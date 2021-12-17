# frozen_string_literal: true

require 'spec_helper'
describe 'CommunityServer FAQ page' do
  test_manager = TestingApiOnlyfficeCom::TestManager.new(suite_name: 'CommunityServer FAQ page', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyfficeCom::TestInstance.new(config)
    api_page = @instance.go_to_main_page
    @faq_page = api_page.go_to_community_server_api.go_to_faq
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'FAQ page correctly opened' do
    expect(@faq_page).to be_a(TestingApiOnlyfficeCom::CommunityServerFaqPage)
  end
end
