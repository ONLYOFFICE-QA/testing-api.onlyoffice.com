# frozen_string_literal: true

require 'spec_helper'

describe 'beta_docs_api' do
  let(:test_manager) { TestingApiOnlyOfficeCom::TestManager.new(suite_name: '[beta] docs', plan_name: config.to_s) }
  let(:element_chapter_nav_root) { "*//chapter-navigation[@class='tree']" }

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @beta_docs_api = @instance.go_to_main_page
                              .go_to_beta_docs
                              .go_to_beta_docs_api
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  it 'BetaDocsApi class has been created' do
    expect(Object.const_defined?('BetaDocsApi')).to be(true)
    expect(Object.const_get('BetaDocsApi')).to be_a(Class)
  end

  it 'docs_api check all img' do
    hrefs = @beta_docs_api.chapter_nav_hrefs(@instance.webdriver.driver.page_source,
                                             element_chapter_nav_root)

    # TODO: skip try-docs because hide nav
    hrefs.delete('/docs/docs-api/get-started/try-docs/')

    hrefs.each do |href|
      expect(DocumentEntry.new(@instance, href, href)
                          .click_by_a_via_href("and contains(@class, 'tree__leaf')")
                          .all_img_exists?).to all(be_truthy)
    end
  end
end
