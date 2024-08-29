# frozen_string_literal: true

require 'spec_helper'

describe 'beta_docs_api' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: '[beta] docspace main', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @beta_docspace = @instance.go_to_main_page
                              .go_to_beta
                              .go_to_beta_docs
                              .go_to_beta_desktop_editors
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'BetaDesktopEditor class has been created' do
    expect(Object.const_defined?('BetaDesktopEditor')).to be(true)
    expect(Object.const_get('BetaDesktopEditor')).to be_a(Class)
  end
end