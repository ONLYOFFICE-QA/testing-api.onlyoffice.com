# frozen_string_literal: true

require 'onlyoffice_documentserver_testing_framework'

module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/18173785/37903128-7b1dcf28-30ff-11e8-828b-c3849e7a758c.png
  # /editors/basic
  class DocumentServerAPI
    include PageObject

    # @return [Array<Symbols>] list of languages with examples
    DOC_SERVER_EXAMPLES = %i[
      c_sharp_mvc
      c_sharp_dotnet
      java
      java_spring
      node_js
      php
      python
      ruby
    ].freeze

    # download links
    link(:c_sharp_mvc, xpath: '//*[contains(@href, "MVC")]')
    link(:c_sharp_dotnet, xpath: '//*[contains(@href, "DotNet")]')
    link(:java, xpath: '//*[contains(@href, "Java Example")]')
    link(:java_spring, xpath: '//*[contains(@href, "Java Spring")]')
    link(:node_js, xpath: '//*[contains(@href, "Node")]')
    link(:php, xpath: '//*[contains(@href, "PHP")]')
    link(:python, xpath: '//*[contains(@href, "Python")]')
    link(:ruby, xpath: '//*[contains(@href, "Ruby")]')

    link(:try_now, xpath: '//a[contains(@href, "editors/try")]')
    link(:try_now_docx_editor, xpath: '//*[contains(@href, "editors/editor?method=docxEditor")]')

    link(:integration_examples, xpath: '//*[contains(@href, "editors/demopreview")]')

    # switchers
    link(:document_editor_demo, xpath: '//*[contains(@class,"demo-tab-panel")]//a[contains(@href,"type=text")]')
    link(:spreadsheet_editor_demo, xpath: '//*[contains(@class,"demo-tab-panel")]//a[contains(@href,"type=spreadsheet")]')
    link(:presentation_editor_demo, xpath: '//*[contains(@class,"demo-tab-panel")]//a[contains(@href,"type=presentation")]')

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { try_now_element.present? }
    end

    def try_now_works?
      try_now_element.click
      wait_to_load
      try_now_docx_editor_element.click
      @instance.webdriver.switch_to_popup
      documents_framework.management.wait_loading_present(40)
      documents_framework.management.wait_for_operation_with_round_status_canvas
    end

    def integration_example_work?(editor = :document)
      go_to_integration_examples
      wait_to_load
      demo_editor_switch_seems_legit? editor
    end

    def go_to_integration_examples
      integration_examples_element.click
      wait_to_load
      self
    end

    def editor_seems_legit?(editor = :document)
      send("#{editor}_editor_demo_element").present? && documents_framework.management.editor_type == editor
    end

    def demo_editor_switch_seems_legit?(editor = :document)
      send("#{editor}_editor_demo_element").click
      @instance.webdriver.wait_until { editor_seems_legit? editor }
    end

    # @return [Integer] How much there is language examples on page
    def examples_count
      @instance.webdriver.get_element_count('//ul[contains(@class, "list-buttons")]/li')
    end

    # Check if example download link is visible on page
    # @param [Symbol] language to check
    # @return [Boolean] result of check
    def example_visible?(language)
      @instance.webdriver.element_visible?(send("#{language}_element"))
    end

    # Check if example can be download
    # @param [Symbol] language to check
    # @return [Boolean] result of check
    def example_downloadable?(language)
      HTTParty.head(send("#{language}_element").href).success?
    end

    private

    # @return [OnlyofficeDocumentserverTestingFramework::TestInstanceDocs] framework of documents
    def documents_framework
      @documents_framework ||= OnlyofficeDocumentserverTestingFramework::TestInstanceDocs.new(webdriver: @instance.webdriver)
    end
  end
end
