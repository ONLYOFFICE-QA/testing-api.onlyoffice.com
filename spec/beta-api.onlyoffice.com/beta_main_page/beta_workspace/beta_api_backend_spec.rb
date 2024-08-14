# frozen_string_literal: true

require 'spec_helper'

describe 'beta_api_backend' do
  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @beta_docspace = @instance.go_to_main_page
                              .go_to_beta
                              .go_to_beta_workspace
                              .go_to_beta_api_backend
  end

  it 'BetaApiBackend class has been created' do
    expect(Object.const_defined?('BetaApiBackend')).to be(true)
    expect(Object.const_get('BetaApiBackend')).to be_a(Class)
  end
end
