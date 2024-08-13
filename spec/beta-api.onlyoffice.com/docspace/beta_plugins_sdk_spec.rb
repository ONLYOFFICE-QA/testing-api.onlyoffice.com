# frozen_string_literal: true

require 'spec_helper'

describe 'beta_plugins-sdk' do
  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @pliginssdk = @instance.go_to_main_page
                           .go_to_beta
                           .go_to_beta_plugins_sdk
  end

  it 'class has been created' do
    expect(Object.const_defined?('BetaPluginsSDK')).to be(true)
    expect(Object.const_get('BetaPluginsSDK')).to be_a(Class)
  end
end
