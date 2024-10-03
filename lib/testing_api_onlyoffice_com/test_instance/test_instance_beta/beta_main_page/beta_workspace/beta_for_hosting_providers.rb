# frozen_string_literal: true

require_relative '../beta_workspace'

module TestingApiOnlyOfficeCom
  # For hosting providers page
  # https://github.com/user-attachments/assets/62240fd6-a2d6-4ffd-bf65-83f44a4074f9
  class BetaForHostingProviders
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
