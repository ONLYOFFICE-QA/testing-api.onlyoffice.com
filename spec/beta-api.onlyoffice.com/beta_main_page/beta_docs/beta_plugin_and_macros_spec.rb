# frozen_string_literal: true

require 'spec_helper'

describe 'beta_plugin_and_macros_api' do
  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @beta_docspace = @instance.go_to_main_page
                              .go_to_beta
                              .go_to_beta_docs
                              .go_to_beta_plugin_and_macros
  end

  it 'BetaPluginAndMacros class has been created' do
    expect(Object.const_defined?('BetaPluginAndMacros')).to be(true)
    expect(Object.const_get('BetaPluginAndMacros')).to be_a(Class)
  end
end
