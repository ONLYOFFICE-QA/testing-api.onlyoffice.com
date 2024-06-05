# frozen_string_literal: true

require_relative '../test_instance'
require_relative 'main_page/docs_page_requires'
require_relative 'main_page/community_server_api'
require_relative 'main_page/docspace_api'

module TestingApiOnlyOfficeCom
  # Main page of api.onlyoffice.com
  # TODO: screen
  class MainPage
    include PageObject

    SUBMENU = '//ul[contains(@class, "top-nav all-menu-items")]//li[contains(@class, "pushy-submenu")]'
    # menu items
    link(:docspace, xpath: "#{SUBMENU}//a[@href='/docspace']")
    link(:docs, xpath: "#{SUBMENU}//a[@href='/docs']")
    link(:portals, xpath: "#{SUBMENU}//a[@href='/portals']")
    # docspace
    link(:workspaceapi, xpath: "#{SUBMENU}//a[@href='/portals/workspaceapi']")
    # docs
    link(:docs_api, xpath: "#{SUBMENU}//a[@href='/editors/basic']")
    link(:office_api, xpath: "#{SUBMENU}//a[@href='/officeapi/basic']")
    link(:document_builder, xpath: "#{SUBMENU}//a[@href='/docbuilder/basic']")
    # workspace
    link(:docspace_backend, xpath: "#{SUBMENU}//a[@href='/docspace/backend']")

    # pages_els
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

    def go_to_workspace_api
      action_move_to(portals_element.element.selector[:xpath])
      workspaceapi_element.click
      CommunityServerAPI.new(@instance)
    end

    def go_to_docs
      docs_element.click
      DocsPage.new(@instance)
    end

    def go_to_document_builder
      action_move_to(docs_element.element.selector[:xpath])
      document_builder_element.click
      DocumentBuilderPage.new(@instance)
    end

    def go_to_docs_api
      action_move_to(docs_element.element.selector[:xpath])
      docs_api_element.click
      DocsApiPage.new(@instance)
    end

    def go_to_docspace_backend
      action_move_to(docspace_element.element.selector[:xpath])
      docspace_backend_element.click
      DocSpaceAPI.new(@instance)
    end

    def sidebar_visible?
      sidebar_element.present?
    end

    def portals_api_visible?
      portals_element.present?
    end

    # Change language of page
    # @param [String] language - language to change to
    # @return [nil]
    def change_language(language)
      @instance.webdriver.open("#{@instance.webdriver.current_url}/#{language}")
      if language == 'zh'
        # Chinese language docs have only one page
        DocsApiPage.new(@instance)
      else
        self
      end
    end

    # TODO: put it in a separate module
    # @param [Object] xpath
    # @return [Object]
    def action_move_to(xpath)
      workspaceapi = @instance.webdriver.driver.find_element(:xpath, xpath)
      action = @instance.webdriver.driver.action
      action.move_to(workspaceapi).perform
    end
  end
end
