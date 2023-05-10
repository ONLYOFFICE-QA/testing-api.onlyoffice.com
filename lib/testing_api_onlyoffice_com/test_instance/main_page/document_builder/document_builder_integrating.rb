# frozen_string_literal: true

require_relative 'document_builder_api_common/document_builder'
require_relative 'document_builder_api_common/builder_page'
module TestingApiOnlyOfficeCom
  # https://user-images.githubusercontent.com/40513035/55968370-8945c400-5c84-11e9-9dda-4e2402268a00.png
  # /docbuilder/integratingdocumentbuilder
  class DocumentBuilderIntegrating < BuilderPage
    include DocumentBuilder

    DEFAULT_BUILDER_FILE_NAME = 'SampleText.docx'

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
      super
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { generate_document_element.present? }
    end

    # @return [Integer] How much there is language examples on page
    def examples_count
      @instance.webdriver.get_element_count('//ul[contains(@class, "list-buttons")]/li')
    end

    # Check if example download link is visible on page
    # @param [Symbol] language to check
    # @return [Boolean] result of check
    def example_visible?(language)
      @instance.webdriver.element_visible?(send("#{language}_element"))
    end

    # Check if example can be download
    # @param [Symbol] language to check
    # @return [Boolean] result of check
    def example_downloadable?(language)
      HTTParty.head(send("#{language}_element").href).success?
    end
  end
end