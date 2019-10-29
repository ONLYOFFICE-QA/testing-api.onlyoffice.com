# frozen_string_literal: true

require_relative 'main_page/community_server_api'
require_relative 'main_page/document_builder_api'
require_relative 'main_page/document_server_api'

module TestingApiOnlyfficeCom
  # Main page of api.onlyoffice.com
  # https://user-images.githubusercontent.com/668524/47566467-85232580-d934-11e8-9c93-1e2fce0b4bfd.png
  class MainPage
    include PageObject

    link(:portals, xpath: '//a[@href="/portals/basic"]')
    link(:document_builder, xpath: '//a[@href="/docbuilder/basic"]')
    link(:document_server, xpath: '//a[@href="/editors/basic"]')
    element(:sidebar, xpath: '//*[contains(@class,"layout-side")]')

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        portals_api_visible? || sidebar_visible?
      end
    end

    def sidebar_visible?
      sidebar_element.present?
    end

    def portals_api_visible?
      portals_element.present?
    end

    def go_to_community_server_api
      portals_element.click
      CommunityServerAPI.new(@instance)
    end

    def go_to_document_builder_introduction
      document_builder_element.click
      DocumentBuilderIntroduction.new(@instance)
    end

    def go_to_document_server_api
      document_server_element.click
      DocumentServerAPI.new(@instance)
    end
  end
end
