require 'json'
require 'onlyoffice_file_helper'
require_relative '../../../../lib/testing_api_onlyoffice_com/test_instance/main_page/helper_for_api_documentation/document_entry'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/18173785/37903128-7b1dcf28-30ff-11e8-828b-c3849e7a758c.png
  # http://api.onlyoffice.com/portals/basic http://api.teamlab.info/portals/basic
  class CommunityServerAPI
    include PageObject

    link(:identification, xpath: '//*[contains(@class, "treeheader")][text()="Portal api methods"]')

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
      @documentation_objects = init_navigation_objects
    end

    def wait_to_load
      @instance.webdriver.wait_until { identification_element.visible? }
    end

    def init_navigation_objects
      documentation_modules = []
      CommunityServerAPI.parse_document_entries.each_pair do |module_name, sections_hash|
        entry = DocumentEntry.new(@instance, "section/#{module_name}", module_name)
        sections_hash.each_pair do |section_name, methods_array|
          entry_class = DocumentEntry.new(@instance, "#{entry.link}/#{section_name}", section_name)
          methods_array.each do |method_name|
            entry_class.children << DocumentEntry.new(@instance, "method/#{module_name}/#{method_name}", method_name)
          end
          entry.children << entry_class
        end
        documentation_modules << entry
      end
      documentation_modules
    end

    def all_documentation_links_ok?
      checked = check_documentation_links
      failed = checked.find_all { |_key, value| value == false }
      [failed.empty?, failed]
    end

    def check_documentation_links
      checked = {}
      CommunityServerAPI.parse_document_entries.each_with_index do |(module_name, section_hash), index|
        checked[module_name] = @documentation_objects[index].visible?
        @documentation_objects[index].click_expend
        section_hash.each do |section_name, methods_array|
          unless section_name == 'unspecified'
            checked[section_name] = @documentation_objects[index][section_name].visible?
            @documentation_objects[index][section_name].click_expend
          end
          methods_array.each do |method_name|
            checked[method_name] = @documentation_objects[index][section_name][method_name].visible?
          end
        end
      end
      checked
    end

    def self.parse_document_entries
      @parse_document_entries ||= JSON.parse(File.read("#{__dir__}/community_server_api/document_entries.json"))
    end
  end
end
