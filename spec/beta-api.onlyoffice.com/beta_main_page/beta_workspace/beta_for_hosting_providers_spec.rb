# frozen_string_literal: true

require 'spec_helper'

describe 'beta_for_hosting_providers' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: '[beta] docspace', plan_name: config.to_s)
  let(:element_chapter_nav_root) { "*//chapter-navigation[@class='tree']" }

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @beta_docspace = @instance.go_to_main_page
                              .go_to_beta
                              .go_to_beta_workspace
                              .go_to_beta_for_hosting_providers
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'BetaForHostingProviders class has been created' do
    expect(Object.const_defined?('BetaForHostingProviders')).to be(true)
    expect(Object.const_get('BetaForHostingProviders')).to be_a(Class)
  end

  it 'check all img' do
    hrefs = @beta_docspace.chapter_nav_hrefs(@instance.webdriver.driver.page_source,
                                             element_chapter_nav_root)

    hrefs.each do |href|
      expect(DocumentEntry.new(@instance, href, href)
                          .click_by_a_via_href("and contains(@class, 'tree__leaf')")
                          .all_img_exists?).to all(be_truthy)
    end
  end
end
