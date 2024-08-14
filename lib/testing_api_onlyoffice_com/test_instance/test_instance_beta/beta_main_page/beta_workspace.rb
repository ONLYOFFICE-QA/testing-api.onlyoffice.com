# frozen_string_literal: true

require_relative '../beta_main_page'

module TestingApiOnlyOfficeCom
  # TODO: image & description
  # class
  class BetaWorkspace
    include PageObject

    attr_accessor :instance

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    link(:api_backend, xpath: "*//div[contains(@class, 'part__chapter')]/*/a[contains(@href, 'api-backend')]")
    link(:for_hosting_providers, xpath: "*//div[contains(@class, 'part__chapter')]/*/a[contains(@href, 'for-hosting-providers')]")

    def wait_to_load
      @instance.webdriver.wait_until do
        api_backend_element.present? and
          for_hosting_providers_element.present?
      end
    end
  end
end
