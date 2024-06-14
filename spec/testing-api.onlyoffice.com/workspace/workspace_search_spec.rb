# frozen_string_literal: true

require 'spec_helper'
describe 'workspace_search' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: 'Workspace Search', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    api_page = @instance.go_to_main_page
    @workspace_api_page = api_page.go_to_workspace_api
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'Non-existing word result in No found search message' do
    result_page = @workspace_api_page.search('Fakeword')
    expect(result_page).to be_no_entries_found
  end

  it 'Non-existing word result in zero found results' do
    result_page = @workspace_api_page.search('Fakeword')
    expect(result_page.search_result_count).to eq(0)
  end

  it 'Search for existing method result several results' do
    result_page = @workspace_api_page.search('auth')
    expect(result_page.search_result_count).to be > 0
  end

  it 'Search input contains search string' do
    search_string = 'auth'
    result_page = @workspace_api_page.search(search_string)
    expect(result_page.search_input_value).to eq(search_string)
  end

  describe 'xss' do
    let(:xss) { '"><script>alert(1)</script>' }

    before do
      pending('https://nct.onlyoffice.com/Products/Projects/Tasks.aspx?prjID=124&id=33647')
    end

    it 'Search for xss will will result no entries' do
      result_page = @workspace_api_page.search(xss)
      expect(result_page).to be_no_entries_found
    end

    it 'Search for xss save value in input field' do
      result_page = @workspace_api_page.search(xss)
      expect(result_page.search_input_value).to eq(xss)
    end
  end
end
