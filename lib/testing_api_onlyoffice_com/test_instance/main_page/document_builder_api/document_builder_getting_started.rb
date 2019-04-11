require 'httparty'
require 'onlyoffice_file_helper'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/40513035/55968227-48e64600-5c84-11e9-8ca6-90d1057918cd.png
  # /docbuilder/gettingstarted
  class DocumentBuilderGettingStarted
    include PageObject

    # actions
    link(:linuxx64, xpath: '//a[@href="http://download.onlyoffice.com/install/desktop/docbuilder/documentbuilder-x64.tar.gz"]')
    link(:windowsx64, xpath: '//a[@href="http://download.onlyoffice.com/install/desktop/docbuilder/documentbuilder-x64.zip"]')
    link(:windowsx86, xpath: '//a[@href="http://download.onlyoffice.com/install/desktop/docbuilder/documentbuilder-x86.zip"]')

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { windowsx86_element.visible? }
    end

    def download_library_linuxx64_works?
      linuxx64_element.click
      path_to_downloaded_library_linuxx64 = @instance.webdriver.download_directory + '/' + TestData::DEFAULT_LIBRARY_LINUXX64_NAME
      OnlyofficeFileHelper::FileHelper.wait_file_to_download(path_to_downloaded_library_linuxx64)
      file_size_linuxx64 = File.size(path_to_downloaded_library_linuxx64)
      [file_size_linuxx64 > 10_000, file_size_linuxx64]
    end

    def download_library_windowsx64_works?
      windowsx64_element.click
      path_to_downloaded_library_windowsx64 = @instance.webdriver.download_directory + '/' + TestData::DEFAULT_LIBRARY_WINDOWSX64_NAME
      OnlyofficeFileHelper::FileHelper.wait_file_to_download(path_to_downloaded_library_windowsx64)
      file_size_windowsx64 = File.size(path_to_downloaded_library_windowsx64)
      [file_size_windowsx64 > 10_000, file_size_windowsx64]
    end

    def download_library_windowsx86_works?
      windowsx86_element.click
      path_to_downloaded_library_windowsx86 = @instance.webdriver.download_directory + '/' + TestData::DEFAULT_LIBRARY_WINDOWSX86_NAME
      OnlyofficeFileHelper::FileHelper.wait_file_to_download(path_to_downloaded_library_windowsx86)
      file_size_windowsx86 = File.size(path_to_downloaded_library_windowsx86)
      [file_size_windowsx86 > 10_000, file_size_windowsx86]
    end
  end
end
