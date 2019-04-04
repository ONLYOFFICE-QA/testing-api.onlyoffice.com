require 'onlyoffice_file_helper'
require_relative 'document_builder_api_common/left_side_navigation_builder'
require_relative 'document_builder_api_common/document_builder'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/18173785/37905775-9964ebb6-3108-11e8-8f98-480cbb1c2906.png
  # /docbuilder/basic
  class DocumentBuilderIntroduction
    include LeftSideNavigationBuilder
    include DocumentBuilder

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { button_generate_document_visible? }
    end
  end
end
