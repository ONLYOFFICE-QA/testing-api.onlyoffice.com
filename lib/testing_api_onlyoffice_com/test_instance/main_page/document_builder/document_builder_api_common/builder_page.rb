# frozen_string_literal: true

require_relative '../../../documentation_helper/document_entry'

module TestingApiOnlyOfficeCom
  # https://user-images.githubusercontent.com/18173785/37905775-9964ebb6-3108-11e8-8f98-480cbb1c2906.png
  # /docbuilder/basic
  class BuilderPage
    include PageObject
    include CheckMethodLinks

    # actions
    link(:introduction, xpath: '//*[contains(@class, "side-nav")]//a[@href="/docbuilder/basic"]')
    link(:getting_started, xpath: '//*[contains(@href, "/docbuilder/gettingstarted")]')
    link(:integrating_document_builder, xpath: '//*[contains(@href, "/docbuilder/integratingdocumentbuilder")]')
    link(:integrating_document_builder_menu, xpath: '//li[@class="collapsable lastCollapsable"]/div[@class="hitarea collapsable-hitarea lastCollapsable-hitarea"]')

    link(:net_example, xpath: '//a[@href="/docbuilder/csharpexample"]')
    link(:nodejs_example, xpath: '//a[@href="/docbuilder/nodejsexample"]')
    link(:php_example, xpath: '//a[@href="/docbuilder/phpexample"]')
    link(:ruby_example, xpath: '//a[@href="/docbuilder/rubyexample"]')

    link(:search_bar, xpath: '//div[@class="search-input"]')
    link(:search_button, xpath: '//div[@class="layout-side"]//a[@class="btn"]')

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { integrating_document_builder_element.present? }
    end

    def open_introduction
      introduction_element.click
      DocumentBuilderIntroduction.new(@instance)
    end

    def open_getting_started
      getting_started_element.click
      DocumentBuilderGettingStarted.new(@instance)
    end

    def open_integrating_document_builder
      integrating_document_builder_element.click
      DocumentBuilderIntegrating.new(@instance)
    end

    def navigation_objects
      return @navigation_objects if @navigation_objects

      @navigation_objects = []
      BuilderPage.parsed_document_entries.each_pair do |editor_name, classes_array|
        entry = DocumentEntry.new(@instance, editor_name, editor_name)
        classes_array.each_pair do |class_name, methods_array|
          entry_class = DocumentEntry.new(@instance, "#{entry.link}/#{class_name}", class_name)
          methods_array.each do |method_name|
            entry_class.children << DocumentEntry.new(@instance, "#{entry_class.link}/#{method_name}", method_name)
          end
          entry.children << entry_class
        end
        @navigation_objects << entry
      end
      @navigation_objects
    end

    def document_builder_links_ok?
      failed = check_documentation_links(navigation_objects, BuilderPage.parsed_document_entries)
      [failed.empty?, failed]
    end
  end
end
