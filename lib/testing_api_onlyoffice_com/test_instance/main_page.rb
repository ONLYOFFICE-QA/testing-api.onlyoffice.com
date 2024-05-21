# frozen_string_literal: true

require_relative 'main_page/community_server_api'
require_relative 'main_page/document_builder_api'
require_relative 'main_page/document_server_api'
require_relative 'main_page/docspace_api'

module TestingApiOnlyOfficeCom
  # Main page of api.onlyoffice.com
  # https://user-images.githubusercontent.com/668524/47566467-85232580-d934-11e8-9c93-1e2fce0b4bfd.png
  class MainPage
    include PageObject

    ROOT_XPATH = '//ul[contains(@class, "top-nav all-menu-items")]//li[contains(@class, "pushy-submenu")]'
    # menu items
    link(:docspace, xpath: "#{ROOT_XPATH}//a[@href='/docspace']")
    link(:docs, xpath: "#{ROOT_XPATH}//a[@href='/docs']")
    link(:portals, xpath: "#{ROOT_XPATH}//a[@href='/portals']")
    # submenu items
    link(:workspaceapi, xpath: "#{ROOT_XPATH}//a[@href='/portals/workspaceapi']")
    link(:document_builder, xpath: "#{ROOT_XPATH}//a[@href='/docbuilder/basic']")
    link(:document_server, xpath: "#{ROOT_XPATH}//a[@href='/editors/basic']")
    link(:docspace_backend, xpath: "#{ROOT_XPATH}//a[@href='/docspace/backend']")
    div(:sidebar, xpath: "//div[contains(@class,'layout-table-footer')]")

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        portals_api_visible? || sidebar_visible?
      end
    end

    def sidebar_visible?
      sidebar_element.present?
    end

    def portals_api_visible?
      portals_element.present?
    end

    def go_to_workspace_api
      action_move_to(portals_element.element.selector[:xpath])
      workspaceapi_element.click
      CommunityServerAPI.new(@instance)
    end

    def go_to_document_builder_introduction
      action_move_to(docs_element.element.selector[:xpath])
      document_builder_element.click
      DocumentBuilderIntroduction.new(@instance)
    end

    def go_to_document_server_api
      action_move_to(docs_element.element.selector[:xpath])
      document_server_element.click
      DocumentServerAPI.new(@instance)
    end

    def go_to_docspace_backend
      action_move_to(docspace_element.element.selector[:xpath])
      docspace_backend_element.click
      DocSpaceAPI.new(@instance)
    end

    # Change language of page
    # @param [String] language - language to change to
    # @return [nil]
    def change_language(language)
      @instance.webdriver.open("#{@instance.webdriver.current_url}/#{language}")
      if language == 'zh'
        # Chinese language docs have only one page
        DocumentServerAPI.new(@instance)
      else
        self
      end
    end

    # @param [Object] xpath
    # @return [Object]
    def action_move_to(xpath)
      workspaceapi = @instance.webdriver.driver.find_element(:xpath, xpath)
      action = @instance.webdriver.driver.action
      action.move_to(workspaceapi).perform
    end
  end
end
