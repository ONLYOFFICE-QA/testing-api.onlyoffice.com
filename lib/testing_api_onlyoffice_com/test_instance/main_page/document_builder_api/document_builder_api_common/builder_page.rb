require 'json'
require 'onlyoffice_file_helper'
require_relative 'document_entry'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/18173785/37905775-9964ebb6-3108-11e8-8f98-480cbb1c2906.png
  # /docbuilder/basic
  class BuilderPage
    include PageObject

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
      @documentation_objects = init_navigation_objects
    end

    def wait_to_load
      @instance.webdriver.wait_until { integrating_document_builder_element.visible? }
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

    def init_navigation_objects
      documentation_editors = []
      BuilderPage.parse_document_entries.each_pair do |editor_name, classes_array|
        entry = DocumentEntry.new(@instance, editor_name)
        classes_array.each_pair do |class_name, methods_array|
          entry_class = DocumentEntry.new(@instance, "#{entry.link}/#{class_name}")
          methods_array.each do |method_name|
            entry_class.children << DocumentEntry.new(@instance, "#{entry_class.link}/#{method_name}")
          end
          entry.children << entry_class
        end
        documentation_editors << entry
      end
      documentation_editors
    end

    def editors_links_ok?
      checked_editors = check_editors_links
      failed = checked_editors.find_all { |_key, value| value == false }
      [failed.empty?, failed]
    end

    def check_editors_links
      checked_editors = {}
      BuilderPage.parse_document_entries.keys.each_with_index do |editor_name, index|
        checked_editors[editor_name] = @documentation_objects[index].visible?
      end
      checked_editors
    end

    def classes_links_ok?
      checked_classes = check_classes_links
      failed = checked_classes.find_all { |_key, value| value == false }
      [failed.empty?, failed]
    end

    def check_classes_links
      checked_classes = {}
      BuilderPage.parse_document_entries.each_with_index do |(_editor_name, classes_array), index|
        @documentation_objects[index].click_expend
        classes_array.each_key do |class_name|
          checked_classes[class_name] = @documentation_objects[index][class_name].visible?
        end
        checked_classes
      end
    end

    def methods_links_ok?
      checked_methods = check_methods_links
      failed = checked_methods.find_all { |_key, value| value == false }
      [failed.empty?, failed]
    end

    def check_methods_links
      checked_classes = {}
      BuilderPage.parse_document_entries.each_with_index do |(_editor_name, classes_array), index|
        @documentation_objects[index].click_expend
        classes_array.each do |class_name, methods_array|
          @documentation_objects[index][class_name].click_expend
          methods_array.each do |method_name|
            checked_classes[class_name] = @documentation_objects[index][class_name][method_name].visible?
          end
        end
        checked_classes
      end
    end

    def self.parse_document_entries
      @parse_document_entries ||= JSON.parse(File.read("#{__dir__}/document_entries.json"))
    end
  end
end
