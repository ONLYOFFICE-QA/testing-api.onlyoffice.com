# frozen_string_literal: true

require_relative '../beta_docs'

module TestingApiOnlyOfficeCom
  # Desktop editors page
  # https://github.com/user-attachments/assets/32fd77db-6837-4d57-9dd2-6fd772040477
  class BetaDesktopEditor
    include PageObject
    include ChapterNavParser

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
