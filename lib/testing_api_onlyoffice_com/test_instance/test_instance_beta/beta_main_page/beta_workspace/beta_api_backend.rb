# frozen_string_literal: true

require_relative '../beta_workspace'

module TestingApiOnlyOfficeCom
  # Api Backend page
  # https://github.com/user-attachments/assets/228f6392-1228-4b8d-a6d1-a916cc13321d
  class BetaApiBackend
    include PageObject

    attr_accessor :instance

    def initialize(instance)
      @instance = instance
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
