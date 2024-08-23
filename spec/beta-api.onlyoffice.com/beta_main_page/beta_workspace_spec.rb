# frozen_string_literal: true

require 'spec_helper'

describe 'beta_workspace' do
  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @beta_docspace = @instance.go_to_main_page
                              .go_to_beta
                              .go_to_beta_workspace
  end

  it 'BetaWorkspace class has been created' do
    expect(Object.const_defined?('BetaWorkspace')).to be(true)
    expect(Object.const_get('BetaWorkspace')).to be_a(Class)
  end
end
