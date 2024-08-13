# frozen_string_literal: true

require_relative '../beta_main_page'

module TestingApiOnlyOfficeCom
  # TODO: img & description
  # class
  class BetaJavaScriptSDK
    include PageObject

    attr_accessor :instance

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    nav(:breadcrump, xpath: "*//nav[contains(@class, 'breadcrumb')]")
    link(:pre_html, xpath: "*//code[contains(@class, 'language-html')]")

    def wait_to_load
      pre_html_element.present? and breadcrump_element.present?
    end
  end
end
