# frozen_string_literal: true

require_relative '../beta_docspace'

module TestingApiOnlyOfficeCom
  # For Hosting Providers page
  # https://github.com/user-attachments/assets/8831e397-80f1-4741-bc36-9a34c3ba20de
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
        breadcrump_element.present? and content_element.present?
      end
    end
  end
end
