# frozen_string_literal: true

require 'spec_helper'

describe 'beta_docspace' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: '[beta] docspace main', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @beta_docspace = @instance.go_to_main_page
                              .go_to_beta
                              .go_to_beta_docspace
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'class has been created' do
    expect(Object.const_defined?('BetaDocSpace')).to be(true)
    expect(Object.const_get('BetaDocSpace')).to be_a(Class)
  end
end
