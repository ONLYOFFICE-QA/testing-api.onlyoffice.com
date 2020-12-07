# frozen_string_literal: true

require_relative 'document_builder_api_common/document_builder'
require_relative 'document_builder_api_common/builder_page'
module TestingApiOnlyfficeCom
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

    def check_download_links
      checked = {}
      DOC_BUILDER_EXAMPLES.each do |ex|
        link = send("#{ex}_element")
        checked["#{ex}_visibility"] = link.present?
        checked["#{ex}_downloadable"] = HTTParty.head(link.href).success? if link.present?
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
