# frozen_string_literal: true

require_relative '../beta_docspace'

module TestingApiOnlyOfficeCom
  # JavaScriptSDK page
  # https://github.com/user-attachments/assets/44620e8b-64ba-4285-82ef-daa64490d633
  class BetaJavaScriptSDK
    include PageObject

    attr_accessor :instance

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    nav(:breadcrump, xpath: "*//nav[contains(@class, 'breadcrumb')]")

    def wait_to_load
      @instance.webdriver.wait_until do
        breadcrump_element.present?
      end
    end
  end
end
