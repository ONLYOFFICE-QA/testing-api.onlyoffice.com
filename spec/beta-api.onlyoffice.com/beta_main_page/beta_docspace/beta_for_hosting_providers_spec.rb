# frozen_string_literal: true

require 'spec_helper'

describe 'beta_api_for_hosting_providers' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: '[beta] for hosting providers', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @pliginssdk = @instance.go_to_main_page
                           .go_to_beta
                           .go_to_beta_docspace
                           .go_to_beta_for_hosting_providers
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'BetaForHostingProviders class has been created' do
    expect(Object.const_defined?('BetaForHostingProviders')).to be(true)
    expect(Object.const_get('BetaForHostingProviders')).to be_a(Class)
  end
end
