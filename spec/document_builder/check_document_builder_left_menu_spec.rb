require 'spec_helper'

describe 'document_builder_left_menu' do

  before :each do
    @instance = TestingApiOnlyfficeCom::TestInstance.new(@config)
    api_page = @instance.go_to_main_page
    @introduction_page = api_page.go_to_document_builder_introduction
  end

  context 'left_menu' do
    it "Introduction" do
      result = @introduction_page.button_generate_document_visible?
      expect(result).to be_truthy
    end
  end
  after :each do
    @instance.webdriver.quit
  end
end



