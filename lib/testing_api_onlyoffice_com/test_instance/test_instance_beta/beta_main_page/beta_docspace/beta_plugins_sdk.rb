# frozen_string_literal: true

require_relative '../beta_docspace'

module TestingApiOnlyOfficeCom
  # PluginsSDK page
  # https://github.com/user-attachments/assets/b806ce4b-4526-40b0-abc1-c243c6814c8f
  class BetaPluginsSDK
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
