# frozen_string_literal: true

require 'spec_helper'

describe 'beta_docs' do
  let(:test_manager) { TestingApiOnlyOfficeCom::TestManager.new(suite_name: '[beta] docs', plan_name: config.to_s) }

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @beta_docs = @instance.go_to_main_page
                          .go_to_beta
                          .go_to_beta_docs
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'BetaDocs class has been created' do
    expect(Object.const_defined?('BetaDocs')).to be(true)
    expect(Object.const_get('BetaDocs')).to be_a(Class)
  end
end
