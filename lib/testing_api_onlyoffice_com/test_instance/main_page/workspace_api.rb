# frozen_string_literal: true

require_relative '../documentation_helper/check_method_links'
require_relative 'workspace/workspace_faq_page'
require_relative 'workspace/workspace_method_page'

module TestingApiOnlyOfficeCom
  # TODO: screen
  # screen
  class WorkspaceAPI
    include PageObject
    include CheckMethodLinks
    include SearchSidebar

    link(:identification, xpath: '//a[@href="/portals/workspaceapi/auth"]')

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { identification_element.present? }
    end

    def navigation_objects
      return @navigation_objects if @navigation_objects

      @navigation_objects = []

      TestData.workspace_api_backend.each_pair do |module_name, sections_hash|
        entry = DocumentEntry.new(@instance, "section/#{module_name}", module_name)

        sections_hash.each_pair do |section_name, methods_array|
          entry_class = DocumentEntry.new(@instance, "#{entry.link}/#{section_name}", section_name)

          methods_array.each do |method_name|
            entry_class.children << DocumentEntry.new(@instance, "method/#{module_name}/#{method_name}", method_name)
          end
          entry.children << entry_class
        end
        @navigation_objects << entry
      end
      @navigation_objects
    end

    def workspace_links_ok?
      failed = check_documentation_links(navigation_objects, TestData.workspace_api_backend)
      [failed.empty?, failed]
    end

    # Go to FAQ page
    # @return [WorkspaceFaqPage]
    def go_to_faq
      @instance.webdriver.click_on_locator('//a[contains(@href, "faq")]')
      WorkspaceFaqPage.new(@instance)
    end
  end
end
