# frozen_string_literal: true

require_relative '../beta_docspace'

module TestingApiOnlyOfficeCom
  # Api Backend page
  # https://github.com/user-attachments/assets/26d9ed97-c76c-4159-8424-b6bfb1d87cd4
  class BetaApiBackend
    include PageObject
    include ChapterNavParser

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
