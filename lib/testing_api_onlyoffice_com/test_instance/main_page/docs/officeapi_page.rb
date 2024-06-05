# frozen_string_literal: true

require_relative '../../documentation_helper/check_method_links'

module TestingApiOnlyOfficeCom
  # TODO: screen

  # TODO: documentation
  # doc mock
  class OfficeApiPage
    include PageObject
    include CheckMethodLinks

    div(:product_version_label, xpath: "//*[contains(@class, 'pvl_wrapper')]")

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { product_version_label_element.present? }
    end

    def document_builder_links_ok?
      failed = check_documentation_links(navigation_objects, TestData.document_builder_usage_api)
      [failed.empty?, failed]
    end

    def navigation_objects
      return @navigation_objects if @navigation_objects

      @navigation_objects = []
      TestData.document_builder_usage_api.each_pair do |editor_name, classes_array|
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
  end
end
