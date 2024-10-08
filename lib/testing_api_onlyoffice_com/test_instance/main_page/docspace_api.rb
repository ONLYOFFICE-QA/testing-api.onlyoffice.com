# frozen_string_literal: true

require_relative '../documentation_helper/check_method_links'
require_relative 'docspace/docspace_method_page'

module TestingApiOnlyOfficeCom
  # https://github.com/ONLYOFFICE-QA/testing-api.onlyoffice.com/assets/60688343/dc2900eb-905f-4de9-987a-cd407e315868
  # http://api.onlyoffice.com/docspace/basic http://api.teamlab.info/docspace/basic
  class DocSpaceAPI
    include PageObject
    include CheckMethodLinks

    attr_accessor :instance
    attr_reader :document_entries_json

    link(:identification, xpath: '//a[@href="/docspace/backend/"]')

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      @document_entries_json = TestData.docspace_api_backend
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { identification_element.present? }
    end

    def backend_links_ok?
      init_navigation_object
      failed = check_documentation_links(@navigation_object, @document_entries_json)
      [failed.empty?, failed]
    end

    def init_navigation_object
      return @navigation_object if @navigation_object

      @navigation_object = []

      @document_entries_json.each_pair do |module_name, sections_hash|
        entry = DocumentEntry.new(@instance, "section/#{module_name}", module_name)

        sections_hash.each_pair do |section_name, methods_array|
          entry_class = DocumentEntry.new(@instance, "#{entry.link}/#{section_name}", section_name)

          methods_array.each do |method_name|
            entry_class.children << DocumentEntry.new(@instance, "method/#{module_name}/#{method_name}", method_name)
          end
          entry.children << entry_class
        end
        @navigation_object << entry
      end
    end
  end
end
