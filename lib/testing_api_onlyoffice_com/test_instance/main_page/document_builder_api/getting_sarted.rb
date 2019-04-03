require 'httparty'
require 'onlyoffice_file_helper'
require_relative 'left_side_navigation'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/18173785/37905775-9964ebb6-3108-11e8-8f98-480cbb1c2906.png
  # /docbuilder/basic
  class DocumentBuilderGettingStared
    include PageObject
    include LeftSideNavigation

    # actions
    link(:getting_started, xpath: '//div[@class="layout-side"]//a[@href="/docbuilder/gettingstarted"]')
    link(:linuxx64, xpath: '//a[@href="http://download.onlyoffice.com/install/desktop/docbuilder/documentbuilder-x64.tar.gz"]')
    link(:windowsx64, xpath: '//a[@href="http://download.onlyoffice.com/install/desktop/docbuilder/documentbuilder-x64.zip"]')
    link(:windowsx86, xpath: '//a[@href="http://download.onlyoffice.com/install/desktop/docbuilder/documentbuilder-x86.zip"]')

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { windowsx86.visible? }
    end

    def button_windowsx86_visible?
      windowsx86_element.visible?
    end
  end
end
