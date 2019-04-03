require 'httparty'
require 'onlyoffice_file_helper'
require_relative 'left_side_navigation'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/18173785/37905775-9964ebb6-3108-11e8-8f98-480cbb1c2906.png
  # /docbuilder/basic
  class DocumentBuilderIntroduction
    include PageObject
    include LeftSideNavigation

    DEFAULT_BUILDER_FILE_NAME = 'SampleText.docx'.freeze


    # actions
    # introduction
    link(:introduction, xpath: '//a[@class="selected"]')
    link(:generate_document, xpath: '//*[@id="generateButton"]')


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

    def button_generate_document_visible?
      generate_document_element.visible?
    end

  end
end
