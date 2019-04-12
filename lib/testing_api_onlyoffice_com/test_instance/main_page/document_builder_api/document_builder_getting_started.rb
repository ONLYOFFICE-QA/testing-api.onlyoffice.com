require 'httparty'
require 'onlyoffice_file_helper'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/40513035/55968227-48e64600-5c84-11e9-8ca6-90d1057918cd.png
  # /docbuilder/gettingstarted
  class DocumentBuilderGettingStarted
    include PageObject

    # actions
    link(:linux_x64, xpath: '//a[@href="http://download.onlyoffice.com/install/desktop/docbuilder/documentbuilder-x64.tar.gz"]')
    link(:windows_x64, xpath: '//a[@href="http://download.onlyoffice.com/install/desktop/docbuilder/documentbuilder-x64.zip"]')
    link(:windows_x86, xpath: '//a[@href="http://download.onlyoffice.com/install/desktop/docbuilder/documentbuilder-x86.zip"]')

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { windows_x86_element.visible? }
    end

    def download_library_linux_x64_works?
      linux_x64_element.click
      path_to_downloaded_library_linux_x64 = @instance.webdriver.download_directory + '/' + TestData::DEFAULT_LIBRARY_LINUX_X64_NAME
      OnlyofficeFileHelper::FileHelper.wait_file_to_download(path_to_downloaded_library_linux_x64)
      file_size_linux_x64 = File.size(path_to_downloaded_library_linux_x64)
      [file_size_linux_x64 > 10_000, file_size_linux_x64]
    end

    def download_library_windows_x64_works?
      windows_x64_element.click
      path_to_downloaded_library_windows_x64 = @instance.webdriver.download_directory + '/' + TestData::DEFAULT_LIBRARY_WINDOWS_X64_NAME
      OnlyofficeFileHelper::FileHelper.wait_file_to_download(path_to_downloaded_library_windows_x64)
      file_size_windows_x64 = File.size(path_to_downloaded_library_windows_x64)
      [file_size_windows_x64 > 10_000, file_size_windows_x64]
    end

    def download_library_windows_x86_works?
      windows_x86_element.click
      path_to_downloaded_library_windows_x86 = @instance.webdriver.download_directory + '/' + TestData::DEFAULT_LIBRARY_WINDOWS_X86_NAME
      OnlyofficeFileHelper::FileHelper.wait_file_to_download(path_to_downloaded_library_windows_x86)
      file_size_windows_x86 = File.size(path_to_downloaded_library_windows_x86)
      [file_size_windows_x86 > 10_000, file_size_windows_x86]
    end
  end
end
