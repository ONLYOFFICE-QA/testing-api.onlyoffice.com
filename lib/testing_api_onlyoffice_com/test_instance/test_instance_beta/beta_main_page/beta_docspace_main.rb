# frozen_string_literal: true

require_relative '../beta_main_page'

module TestingApiOnlyOfficeCom
  # TODO: image & description
  # class
  class BetaDocSpaceMainPage
    include PageObject

    attr_accessor :instance

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    link(:h3_javascript_sdk, xpath: "*//h3/a[contains(@href, 'javascript-sdk')]")
    link(:javascript_sdk, xpath: "*//a[contains(@class, 'global-navigation__submenu-link') and contains(@href, 'docspace') and contains(@href, 'javascript-sdk')]")

    def wait_to_load
      h3_javascript_sdk_element.present? and javascript_sdk_element.present?
    end

    def action_move_to(xpath)
      element = @instance.webdriver.driver.find_element(:xpath, xpath)
      action = @instance.webdriver.driver.action
      action.move_to(element).perform
    end
  end
end
