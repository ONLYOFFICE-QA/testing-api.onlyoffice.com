# frozen_string_literal: true

require 'spec_helper'

describe 'beta_for_hosting_providers' do
  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @beta_docspace = @instance.go_to_main_page
                              .go_to_beta
                              .go_to_beta_workspace
                              .go_to_beta_for_hosting_providers
  end

  it 'BetaForHostingProviders class has been created' do
    expect(Object.const_defined?('BetaForHostingProviders')).to be(true)
    expect(Object.const_get('BetaForHostingProviders')).to be_a(Class)
  end
end
