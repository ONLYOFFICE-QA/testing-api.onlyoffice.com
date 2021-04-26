# frozen_string_literal: true

require 'spec_helper'
describe 'community_server_search' do
  test_manager = TestingApiOnlyfficeCom::TestManager.new(suite_name: 'Community Server Documentation Links', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyfficeCom::TestInstance.new(config)
    api_page = @instance.go_to_main_page
    @api_community_server_page = api_page.go_to_community_server_api
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'Non-existing word result in No found search message' do
    result_page = @api_community_server_page.search('Fakeword')
    expect(result_page).to be_no_entries_found
  end

  it 'Non-existing word result in zero found results' do
    result_page = @api_community_server_page.search('Fakeword')
    expect(result_page.search_result_count).to eq(0)
  end

  it 'Search for existing method result several results' do
    result_page = @api_community_server_page.search('auth')
    expect(result_page.search_result_count).to be > 0
  end

  it 'Search for xss will not result any strange errors' do
    result_page = @api_community_server_page.search('"><script>alert(1)</script>')
    expect(result_page).to be_no_entries_found
  end
end
