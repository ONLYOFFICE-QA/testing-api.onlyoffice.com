# frozen_string_literal: true

require_relative '../beta_main_page'

module TestingApiOnlyOfficeCom
  # TODO: img & describe
  # class
  class BetaPluginsSDK
    include PageObject

    attr_accessor :instance

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    div(:content, xpath: "*//div[contains(data-search-container-hidable,'')]/div[contains(@class,'content')]")

    def wait_to_load
      @instance.webdriver.wait_until do
        content_element.present?
      end
    end
  end
end
