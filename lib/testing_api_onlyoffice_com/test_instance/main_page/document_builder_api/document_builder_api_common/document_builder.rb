require 'httparty'
require 'onlyoffice_file_helper'
require 'ooxml_parser'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/18173785/37905775-9964ebb6-3108-11e8-8f98-480cbb1c2906.png
  # /docbuilder/basic
  module DocumentBuilder
    include PageObject

    DEFAULT_BUILDER_FILE_NAME = 'SampleText.docx'.freeze
    DEFAULT_BUILDER_DOCX_FILE_NAME = 'Sample.docx'.freeze
    DEFAULT_BUILDER_XLSX_FILE_NAME = 'Sample.xlsx'.freeze

    # actions
    link(:generate_document, xpath: '//*[@id="generateButton"]')
    link(:create_document, xpath: '//*[@id="createDocx"]')
    link(:create_spreadsheet, xpath: '//*[@id="createXlsx"]')

    # @return [String] path to generated file
    def generate_document_from_script
      generate_document_element.click
      path_to_downloaded_file = @instance.webdriver.download_directory + '/' + DEFAULT_BUILDER_FILE_NAME
      OnlyofficeFileHelper::FileHelper.wait_file_to_download(path_to_downloaded_file)
      path_to_downloaded_file
    end

    def builder_works?
      path_to_file = generate_document_from_script
      file_size = File.size(path_to_file)
      [file_size > 10_000, file_size]
    end

    # @return [String] path to docx file created from a sample data
    def create_docx_from_sample_data
      create_document_element.click
      path_to_downloaded_docx_file = @instance.webdriver.download_directory + '/' + DEFAULT_BUILDER_DOCX_FILE_NAME
      OnlyofficeFileHelper::FileHelper.wait_file_to_download(path_to_downloaded_docx_file)
      path_to_downloaded_docx_file
    end

    # @return [String] path to xlsx file created from a sample data
    def create_xlsx_from_sample_data
      create_spreadsheet_element.click
      path_to_downloaded_xlsx_file = @instance.webdriver.download_directory + '/' + DEFAULT_BUILDER_XLSX_FILE_NAME
      OnlyofficeFileHelper::FileHelper.wait_file_to_download(path_to_downloaded_xlsx_file)
      path_to_downloaded_xlsx_file
    end

    def button_generate_document_visible?
      generate_document_element.visible?
    end
  end
end
