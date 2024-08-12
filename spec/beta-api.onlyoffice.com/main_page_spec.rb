# frozen_string_literal: true

require 'spec_helper'

describe 'beta_main_page' do

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @beta = @instance.go_to_main_page
                     .go_to_beta
  end

  it 'there and back' do
    cookies = @beta.all_cookies
    cookies.each do |cookie|
      expect(cookie[:value]).to eq('1') if cookie[:name] == 'X-OO-API'
    end
    @beta.go_to_old_via_cookie
    expect(MainPage.new(@instance)).not_to be_nil
  end
end
