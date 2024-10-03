# frozen_string_literal: true

require 'spec_helper'

describe 'beta_plugins-sdk' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: '[beta] plugins sdk', plan_name: config.to_s)
  let(:element_chapter_nav_root) { "*//chapter-navigation[@class='tree']" }

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @pligins_sdk = @instance.go_to_main_page
                            .go_to_beta
                            .go_to_beta_docspace
                            .go_to_beta_plugins_sdk
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'BetaPluginsSDK class has been created' do
    expect(Object.const_defined?('BetaPluginsSDK')).to be(true)
    expect(Object.const_get('BetaPluginsSDK')).to be_a(Class)
  end

  it 'check all img' do
    hrefs = @pligins_sdk.chapter_nav_hrefs(@instance.webdriver.driver.page_source,
                                           element_chapter_nav_root)

    hrefs.each do |href|
      expect(DocumentEntry.new(@instance, href, href)
                          .click_by_a_via_href("and contains(@class, 'tree__leaf')")
                          .all_img_exists?).to all(be_truthy)
    end
  end
end
