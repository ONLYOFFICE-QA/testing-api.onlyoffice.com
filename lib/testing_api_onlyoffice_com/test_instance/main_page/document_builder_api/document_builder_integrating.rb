require 'onlyoffice_file_helper'
require_relative 'document_builder_api_common/document_builder'
require_relative 'document_builder_api_common/left_side_navigation_builder'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/40513035/55968370-8945c400-5c84-11e9-9dda-4e2402268a00.png
  # /docbuilder/integratingdocumentbuilder
  class DocumentBuilderIntegrating
    include PageObject
    include LeftSideNavigationBuilder
    include DocumentBuilder

    DEFAULT_BUILDER_FILE_NAME = 'SampleText.docx'.freeze

    DOC_BUILDER_EXAMPLES = %i[
      c_sharp_mvc
      c_sharp
      node_js
      php
      ruby
    ].freeze

    # download links
    link(:c_sharp_mvc, xpath: '//*[contains(@href, "MVC")]')
    link(:c_sharp, xpath: '//*[not(contains(@href, "MVC")) and contains(@href, ".Net")]')
    link(:node_js, xpath: '//*[contains(@href, "Node")]')
    link(:php, xpath: '//*[contains(@href, "PHP")]')
    link(:ruby, xpath: '//*[contains(@href, "Ruby")]')

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { generate_document_element.visible? }
    end

    def check_download_links
      open_integrating_document_builder
      checked = {}
      DOC_BUILDER_EXAMPLES.each do |ex|
        link = send("#{ex}_element")
        checked["#{ex}_visibility"] = link.visible?
        checked["#{ex}_downloadable"] = HTTParty.head(link.href).success? if link.visible?
      end
      checked
    end

    def download_links_ok?
      checked = check_download_links
      failed = checked.find_all { |_key, value| value == false }
      [failed.empty?, failed]
    end
  end
end
