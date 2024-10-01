# frozen_string_literal: true

require_relative '../beta_docs'

module TestingApiOnlyOfficeCom
  # TODO: img & describe
  # class
  class BetaDesktopEditor
    include PageObject
    include ChapterNavParser

    attr_accessor :instance

    def initialize(instance)
      @instance = instance
      @link = @instance.webdriver.driver.current_url
      @page_source = @instance.webdriver.driver.page_source
      @xpath_chapter_nav = "*//chapter-navigation[@class='tree']"
      super(@instance.webdriver.driver)
      wait_to_load
    end

    nav(:breadcrump, xpath: "*//nav[contains(@class, 'breadcrumb')]")
    div(:content, xpath: "*//div[contains(data-search-container-hidable,'')]/div[contains(@class,'content')]")

    def wait_to_load
      @instance.webdriver.wait_until do
        content_element.present? and breadcrump_element.present?
      end
    end
  end
end
