# frozen_string_literal: true

require_relative '../../beta_main_page'

module TestingApiOnlyOfficeCom
  # TODO: img & describe
  # class
  class BetaApiBackend
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
