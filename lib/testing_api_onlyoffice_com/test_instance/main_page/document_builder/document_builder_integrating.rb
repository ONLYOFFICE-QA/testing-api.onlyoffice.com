# frozen_string_literal: true

require_relative 'document_builder_api_common/document_builder'
require_relative 'document_builder_api_common/builder_page'

module TestingApiOnlyOfficeCom
  # https://github.com/ONLYOFFICE-QA/testing-api.onlyoffice.com/assets/60688343/72680e2f-dfad-4404-9f26-ee72c0c7a8cd
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
    link(:c_sharp_mvc, xpath: '//li/a[contains(@href, "DotNet.Csharp.MVC.Example")]')
    link(:c_sharp, xpath: '//li/a[contains(@href, "DotNet.Csharp.Example")]')
    link(:node_js, xpath: '//li/a[contains(@href, "Node.js.Example")]')
    link(:php, xpath: '//li/a[contains(@href, "PHP.Example")]')
    link(:ruby, xpath: '//li/a[contains(@href, "Ruby.Example")]')

    def initialize(instance)
      @instance = instance
      super
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { download_element.present? }
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
