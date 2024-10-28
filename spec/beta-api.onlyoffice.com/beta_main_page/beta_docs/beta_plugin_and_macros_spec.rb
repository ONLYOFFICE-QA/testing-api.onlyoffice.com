# frozen_string_literal: true

require 'spec_helper'

describe 'beta_plugin_and_macros_api' do
  let(:test_manager) { TestingApiOnlyOfficeCom::TestManager.new(suite_name: '[beta] docs', plan_name: config.to_s) }
  let(:element_chapter_nav_root) { "*//chapter-navigation[@class='tree']" }

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @beta_plugin_and_macros = @instance.go_to_main_page
                                       .go_to_beta_docs
                                       .go_to_beta_plugin_and_macros
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'BetaPluginAndMacros class has been created' do
    expect(Object.const_defined?('BetaPluginAndMacros')).to be(true)
    expect(Object.const_get('BetaPluginAndMacros')).to be_a(Class)
  end

  it 'plugin_and_macros check all img' do
    hrefs = @beta_plugin_and_macros.chapter_nav_hrefs(@instance.webdriver.driver.page_source,
                                                      element_chapter_nav_root)

    hrefs.each do |href|
      expect(DocumentEntry.new(@instance, href, href)
                          .click_by_a_via_href("and contains(@class, 'tree__leaf')")
                          .all_img_exists?).to all(be_truthy)
    end
  end
end
