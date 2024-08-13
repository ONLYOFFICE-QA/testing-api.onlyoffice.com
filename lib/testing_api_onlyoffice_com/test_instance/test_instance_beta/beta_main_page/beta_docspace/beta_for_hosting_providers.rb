# frozen_string_literal: true

require_relative '../../beta_main_page'

module TestingApiOnlyOfficeCom
  # TODO: image & description
  # class
  class BetaForHostingProviders
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
      breadcrump_element.present? and content_element.present?
    end
  end
end
