# frozen_string_literal: true

require_relative 'helper_for_api_documentation/check_method_links'
module TestingApiOnlyfficeCom
  # TODO: screenshot
  # http://api.onlyoffice.com/docspace/basic http://api.teamlab.info/docspace/basic
  class DocSpaceAPI
    include PageObject
    include CheckMethodLinks

    attr_accessor :instance
    attr_reader :document_entries_json

    link(:identification, xpath: '//a[@href="/docspace/auth"]')

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      @document_entries_json = JSON.parse(File.read("#{__dir__}/docspace_api/document_entries.json"))
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { identification_element.present? }
    end

    def api_backend_links_ok?
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