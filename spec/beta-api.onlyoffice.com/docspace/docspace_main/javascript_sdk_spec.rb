# frozen_string_literal: true

require 'spec_helper'

describe 'javascript-sdk' do
  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @javascript_sdk = @instance.go_to_main_page
                               .go_to_beta
                               .go_to_beta_javascript_sdk
  end

  it 'class has been created' do
    expect(Object.const_defined?('BetaJavaScriptSDK')).to be(true)
    expect(Object.const_get('BetaJavaScriptSDK')).to be_a(Class)
  end
end
