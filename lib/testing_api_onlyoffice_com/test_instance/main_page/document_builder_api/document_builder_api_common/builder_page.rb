require 'onlyoffice_file_helper'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/18173785/37905775-9964ebb6-3108-11e8-8f98-480cbb1c2906.png
  # /docbuilder/basic
  class BuilderPage
    include PageObject

    DOCUMENTATION = { 'Text document API': { Api: {}, ApiBlockLvlSdt: {}, ApiBullet: {}, ApiChart: {},
                                             ApiDocument: {}, ApiDocumentContent: {}, ApiDrawing: {},
                                             ApiFill: {}, ApiGradientStop: {}, ApiImage: {}, ApiInlineLvlSdt: {},
                                             ApiNumbering: {}, ApiNumberingLevel: {}, ApiParagraph: {},
                                             ApiParaPr: {}, ApiPresetColor: {}, ApiRGBColor: {}, ApiRun: {},
                                             ApiSchemeColor: {}, ApiSection: {}, ApiShape: {}, ApiStroke: {},
                                             ApiStyle: {}, ApiTable: {}, ApiTableCell: {}, ApiTableCellPr: {},
                                             ApiTablePr: {}, ApiTableRow: {}, ApiTableRowPr: {}, ApiTableStylePr: {},
                                             ApiTextPr: {}, ApiUniColor: {}, ApiUnsupported: {} },
                      'Spreadsheet API': { Api: {}, ApiBullet: {}, ApiChart: {}, ApiColor: {}, ApiDocument: {},
                                           ApiDocumentContent: {}, ApiDrawing: {}, ApiFill: {}, ApiGradientStop: {},
                                           ApiImage: {}, ApiParagraph: {}, ApiParaPr: {}, ApiRange: {}, ApiRGBColor: {},
                                           ApiRun: {}, ApiSchemeColor: {}, ApiShape: {}, ApiStroke: {}, ApiTextPr: {},
                                           ApiUniColor: {}, ApiWorksheet: {} },
                      'Presentation API': { Api: {}, ApiBullet: {}, ApiChart: {}, ApiDocument: {},
                                            ApiDocumentContent: {}, ApiDrawing: {}, ApiFill: {}, ApiGradientStop: {},
                                            ApiImage: {}, ApiParagraph: {}, ApiParaPr: {}, ApiPresentation: {},
                                            ApiPresetColor: {}, ApiRGBColor: {}, ApiRun: {}, ApiSchemeColor: {},
                                            ApiShape: {}, ApiSlide: {}, ApiStroke: {}, ApiTable: {}, ApiTableCell: {},
                                            ApiTableRow: {}, ApiTextPr: {}, ApiUniColor: {} } }.freeze

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
      @documentation_xpathes = init_navigation_methods
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

    def init_navigation_methods
      documentation_xpathes = {}
      DOCUMENTATION.each_pair do |editor_name, classes_arrey|
        editor = editor_name.downcase.to_s.tr_s(' ', '').to_sym
        editor_xpath = "//*[contains(@href, '#{editor}')]"
        editor_xpath_expend = "(//*[contains(@href, '#{editor}')]/parent::li)[1]/div"
        documentation_xpathes[editor_name] = { xpath: editor_xpath, xpath_expend: editor_xpath_expend, classes: {} }
        classes_arrey.each_key do |class_name|
          current_class = class_name.downcase.to_s.tr_s(' ', '').to_sym
          current_class_xpath = "//*[contains(@href, '#{editor}/#{current_class}')]"
          current_class_xpath_expend = "(//*[contains(@href, '#{editor}/#{current_class}')]/parent::li)[1]/div"
          documentation_xpathes[editor_name][:classes][class_name] = { xpath: current_class_xpath, xpath_expend: current_class_xpath_expend }
        end
      end
      documentation_xpathes
    end

    def editors_links_ok?
      checked_editors = check_editors_links
      failed = checked_editors.find_all { |_key, value| value == false }
      [failed.empty?, failed]
    end

    def check_editors_links
      checked_editors = {}
      DOCUMENTATION.each_key do |editor_name|
        checked_editors[editor_name] = @instance.webdriver.element_visible?(@documentation_xpathes[editor_name][:xpath])
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
      DOCUMENTATION.each_pair do |editor_name, classes_arrey|
        element = @instance.webdriver.get_element(@documentation_xpathes[editor_name][:xpath_expend])
        @instance.webdriver.click(element)
        # wait until expended lists of editors are opened
        sleep 2
        classes_arrey.each_key do |class_name|
          checked_classes[class_name] = @instance.webdriver.element_visible?(@documentation_xpathes[editor_name][:classes][class_name][:xpath])
        end
        checked_classes
      end
    end
  end
end
