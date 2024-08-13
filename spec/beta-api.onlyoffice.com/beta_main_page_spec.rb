# frozen_string_literal: true

require 'spec_helper'

describe 'beta_main_page' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: '[beta] main page', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @beta = @instance.go_to_main_page
                     .go_to_beta
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'there and back' do
    cookies = @beta.all_cookies
    cookies.each do |cookie|
      expect(cookie[:value]).to eq('1') if cookie[:name] == 'X-OO-API'
    end
    @beta.go_to_old_via_cookie
    expect(MainPage.new(@instance)).not_to be_nil
  end
end
