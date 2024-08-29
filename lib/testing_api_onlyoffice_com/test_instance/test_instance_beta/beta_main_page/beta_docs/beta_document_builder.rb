# frozen_string_literal: true

require_relative '../beta_docs'

module TestingApiOnlyOfficeCom
  # Document Builder page
  # https://github.com/user-attachments/assets/8abc71f1-f9ff-4d2d-b613-ba801e83c2a4
  class BetaDocumentBuilder
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
