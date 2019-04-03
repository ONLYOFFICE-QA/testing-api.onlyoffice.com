require 'httparty'
require 'onlyoffice_file_helper'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/18173785/37905775-9964ebb6-3108-11e8-8f98-480cbb1c2906.png
  # /docbuilder/basic
  module DocumentBuilder
    include PageObject

    DEFAULT_BUILDER_FILE_NAME = 'SampleText.docx'.freeze

    # actions
    link(:generate_document, xpath: '//*[@id="generateButton"]')

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
