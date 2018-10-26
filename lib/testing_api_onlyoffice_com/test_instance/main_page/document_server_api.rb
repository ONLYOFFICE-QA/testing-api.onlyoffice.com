require 'onlyoffice_documentserver_testing_framework'

module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/18173785/37903128-7b1dcf28-30ff-11e8-828b-c3849e7a758c.png
  # /editors/basic
  class DocumentServerAPI
    include PageObject

    DOC_SERVER_EXAMPLES = %i[
      c_sharp_mvc
      c_sharp
      java
      node_js
      php
      ruby
    ].freeze

    # download links
    link(:c_sharp_mvc, xpath: '//*[contains(@href, "MVC")]')
    link(:c_sharp, xpath: '//*[not(contains(@href, "MVC")) and contains(@href, ".Net")]')
    link(:java, xpath: '//*[contains(@href, "Java")]')
    link(:node_js, xpath: '//*[contains(@href, "Node")]')
    link(:php, xpath: '//*[contains(@href, "PHP")]')
    link(:ruby, xpath: '//*[contains(@href, "Ruby")]')

    link(:try_now, xpath: '//*[contains(@href, "editors/try")]')
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
      @instance.webdriver.wait_until { try_now_element.visible? }
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
    end

    def editor_seems_legit?(editor = :document)
      send("#{editor}_editor_demo_element").visible? && documents_framework.management.editor_type == editor
    end

    def demo_editor_switch_seems_legit?(editor = :document)
      send("#{editor}_editor_demo_element").click
      @instance.webdriver.wait_until { editor_seems_legit? editor }
    end

    def check_download_links
      checked = {}
      DOC_SERVER_EXAMPLES.each do |ex|
        link = send("#{ex}_element")
        checked["#{ex}_visibility"] = link.visible?
        checked["#{ex}_downloadable"] = HTTParty.head(link.href).success? if link.visible?
      end
      checked
    end

    def download_links_ok?
      checked = check_download_links
      failed = checked.find_all { |_key, value| value == false }
      [failed.empty?, failed]
    end

    private

    # @return [OnlyofficeDocumentserverTestingFramework::TestInstanceDocs] framework of documents
    def documents_framework
      @documents_framework ||= OnlyofficeDocumentserverTestingFramework::TestInstanceDocs.new(webdriver: @instance.webdriver)
    end
  end
end
