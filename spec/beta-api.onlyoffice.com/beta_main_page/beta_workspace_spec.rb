# frozen_string_literal: true

require 'spec_helper'

describe 'beta_workspace' do
  let(:test_manager) { TestingApiOnlyOfficeCom::TestManager.new(suite_name: '[beta] workspace', plan_name: config.to_s) }

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @beta_workspace = @instance.go_to_main_page
                               .go_to_beta_workspace
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'BetaWorkspace class has been created' do
    expect(Object.const_defined?('BetaWorkspace')).to be(true)
    expect(Object.const_get('BetaWorkspace')).to be_a(Class)
  end
end
