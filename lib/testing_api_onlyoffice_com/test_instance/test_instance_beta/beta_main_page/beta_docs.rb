# frozen_string_literal: true

require_relative '../beta_main_page'
require_relative 'beta_docs/beta_docs_api'
require_relative 'beta_docs/beta_office_api'
require_relative 'beta_docs/beta_plugin_and_macros'

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

    def go_to_beta_docs_api
      docs_api_element.when_visible.click
      BetaDocsApi.new(@instance)
    end

    def go_to_beta_office_api
      office_api_element.when_visible.click
      BetaOfficeApi.new(@instance)
    end

    def go_to_beta_plugin_and_macros
      plugin_and_macros_element.when_visible.click
      BetaPluginAndMacros.new(@instance)
    end

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
