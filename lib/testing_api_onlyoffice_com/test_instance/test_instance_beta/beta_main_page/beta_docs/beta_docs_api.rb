# frozen_string_literal: true

require_relative '../beta_docs'

module TestingApiOnlyOfficeCom
  # Docs API page
  # https://github.com/user-attachments/assets/46453c92-7d09-4018-869b-dba6848aaf6c
  class BetaDocsApi
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
