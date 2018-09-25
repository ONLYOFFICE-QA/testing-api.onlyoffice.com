require 'httparty'
require 'onlyoffice_file_helper'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/18173785/37905775-9964ebb6-3108-11e8-8f98-480cbb1c2906.png
  # /docbuilder/basic
  class DocumentBuilderAPI
    include PageObject

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

    # actions
    link(:generate_document, xpath: '//*[@id="generateButton"]')
    link(:integrating_document_builder, xpath: '//*[contains(@href, "/docbuilder/integratingdocumentbuilder")]')

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { generate_document_element.visible? }
    end

    def builder_works?
      generate_document_element.click
      path_to_downloaded_file = @instance.webdriver.download_directory + '/' + DEFAULT_BUILDER_FILE_NAME
      OnlyofficeFileHelper::FileHelper.wait_file_to_download(path_to_downloaded_file)
      file_size = File.size(path_to_downloaded_file)
      [file_size > 10_000, file_size]
    end

    def open_integrating_document_builder
      integrating_document_builder_element.click
      wait_to_load
    end

    def check_download_links
      open_integrating_document_builder
      checked = {}
      DOC_BUILDER_EXAMPLES.each do |ex|
        link = eval("#{ex}_element")
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
