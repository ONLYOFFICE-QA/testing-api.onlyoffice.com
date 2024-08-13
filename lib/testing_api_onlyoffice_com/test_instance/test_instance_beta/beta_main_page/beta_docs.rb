# frozen_string_literal: true

require_relative '../beta_main_page'

module TestingApiOnlyOfficeCom
  # TODO: image & description
  # class
  class BetaDocs
    include PageObject

    attr_accessor :instance

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    link(:docs_api, xpath: "*//div[contains(@class, 'part__chapter')]/*/a[contains(@href, 'docs-api')]")
    link(:office_api, xpath: "*//div[contains(@class, 'part__chapter')]/*/a[contains(@href, 'office-api')]")
    link(:plugin_and_macros, xpath: "*//div[contains(@class, 'part__chapter')]/*/a[contains(@href, 'plugin-and-macros')]")
    link(:document_builder, xpath: "*//div[contains(@class, 'part__chapter')]/*/a[contains(@href, 'document-builder')]")
    link(:desktop_editors, xpath: "*//div[contains(@class, 'part__chapter')]/*/a[contains(@href, 'desktop-editors')]")

    def wait_to_load
      @instance.webdriver.wait_until do
        docs_api_element.present? and
          office_api_element.present? and
          plugin_and_macros_element.present? and
          document_builder_element.present? and
          desktop_editors_element.present?
      end
    end
  end
end
