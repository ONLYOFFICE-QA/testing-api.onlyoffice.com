# frozen_string_literal: true

require 'spec_helper'

describe 'beta_main_page' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: '[beta] main', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @beta = @instance.go_to_main_page
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'BetaMainPage class has been created' do
    expect(Object.const_defined?('BetaMainPage')).to be(true)
    expect(Object.const_get('BetaMainPage')).to be_a(Class)
  end
end
