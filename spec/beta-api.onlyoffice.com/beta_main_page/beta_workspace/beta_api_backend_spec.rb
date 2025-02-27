# frozen_string_literal: true

require 'spec_helper'

describe 'beta_api_backend' do
  let(:test_manager) { TestingApiOnlyOfficeCom::TestManager.new(suite_name: '[beta] workspace', plan_name: config.to_s) }
  let(:element_chapter_nav_root) { "*//chapter-navigation[@class='tree']" }

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @api_backend = @instance.go_to_main_page
                            .go_to_beta_workspace
                            .go_to_beta_api_backend
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'BetaApiBackend class has been created' do
    expect(Object.const_defined?('BetaApiBackend')).to be(true)
    expect(Object.const_get('BetaApiBackend')).to be_a(Class)
  end

  it 'api_backend check all img' do
    hrefs = @api_backend.chapter_nav_hrefs(@instance.webdriver.driver.page_source,
                                           element_chapter_nav_root)

    hrefs.each do |href|
      expect(DocumentEntry.new(@instance, href, href)
                          .click_by_a_via_href("and contains(@class, 'tree__leaf')")
                          .all_img_exists?).to all(be_truthy)
    end
  end
end
