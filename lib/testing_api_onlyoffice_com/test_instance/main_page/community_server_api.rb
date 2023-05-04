# frozen_string_literal: true

require_relative '../documentation_helper/check_method_links'
require_relative 'community_server/community_server_faq_page'
require_relative 'community_server/community_server_method_page'
module TestingApiOnlyOfficeCom
  # https://user-images.githubusercontent.com/18173785/37903128-7b1dcf28-30ff-11e8-828b-c3849e7a758c.png
  # http://api.onlyoffice.com/portals/basic http://api.teamlab.info/portals/basic
  class CommunityServerAPI
    include PageObject
    include CheckMethodLinks
    include SearchSidebar

    link(:identification, xpath: '//a[@href="/portals/auth"]')

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
      CommunityServerAPI.parsed_document_entries.each_pair do |module_name, sections_hash|
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

    def community_server_links_ok?
      failed = check_documentation_links(navigation_objects, CommunityServerAPI.parsed_document_entries)
      [failed.empty?, failed]
    end

    def self.parsed_document_entries
      @parsed_document_entries ||= JSON.parse(File.read("#{__dir__}/community_server/document_entries.json"))
    end

    # Go to FAQ page
    # @return [CommunityServerFaqPage]
    def go_to_faq
      @instance.webdriver.click_on_locator('//a[contains(@href, "faq")]')
      CommunityServerFaqPage.new(@instance)
    end
  end
end
