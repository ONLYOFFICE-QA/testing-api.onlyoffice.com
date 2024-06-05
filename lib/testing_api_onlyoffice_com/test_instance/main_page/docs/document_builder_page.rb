# frozen_string_literal: true

require_relative 'document_builder_api_common/document_builder_in_action_logic'

module TestingApiOnlyOfficeCom
  # TODO: screen
  # /docbuilder/basic
  class DocumentBuilderPage
    include PageObject
    include DocumentBuilderInActionLogic

    link(:integrating_document_builder, xpath: '//a[contains(@href, "/docbuilder/integratingdocumentbuilder")]')

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { button_generate_document_visible? }
    end

    def move_to_builder_server_section
      integrating_document_builder_element.click
      DocumentBuilderIntegrating.new(@instance)
    end
  end
end
