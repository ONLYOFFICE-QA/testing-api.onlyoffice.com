# frozen_string_literal: true

require_relative '../../documentation_helper/document_entry'
require_relative '../../documentation_helper/check_method_links'

module TestingApiOnlyOfficeCom
  # TODO: screen
  # /docs
  class DocsPage
    include PageObject
    include CheckMethodLinks

    SUBMENU = '//ul[contains(@class, "top-nav all-menu-items")]//li[contains(@class, "pushy-submenu")]'

    link(:docs_submenu, xpath: "#{SUBMENU}//a[@href='/docs']")

    link(:office_api, xpath: "#{SUBMENU}//a[@href='/officeapi/basic']")

    div(:category_items, xpath: "//*[contains(@class, 'category-items')]")

    elements(:layout_table_footer_links, xpath: '//a[contains(@target, "_blank")]')

    def initialize(instance)
      @logger = Logger.new($stdout)
      # TODO: put it logger in a module
      @logger.level = Logger::INFO
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { category_items_element.present? }
    end

    def go_to_office_api
      action_move_to(docs_submenu_element.element.selector[:xpath])
      office_api_element.click
      OfficeApiPage.new(@instance)
    end

    def open_integrating_document_builder
      integrating_document_builder_element.click
      DocumentBuilderIntegrating.new(@instance)
    end

    # TODO: put it in a separate module
    # @param [Object] xpath
    # @return [Object]
    def action_move_to(xpath)
      workspaceapi = @instance.webdriver.driver.find_element(:xpath, xpath)
      action = @instance.webdriver.driver.action
      action.move_to(workspaceapi).perform
    end

    def footer_links
      result = {}
      layout_table_footer_links_elements.each do |element|
        result.merge!("#{element.href}": element.visible?)
      end
      result
    end

    # TODO: put it in a separate module
    def survey_of_external_links
      result = {}
      layout_table_footer_links_elements.each do |element|
        uri = URI(element.href)
        res = Net::HTTP.get_response(uri)
        @logger.info("#{uri}: #{res.code}")
        result.merge!("#{uri}": res.code)
      end
    end
  end
end
