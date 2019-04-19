require 'onlyoffice_file_helper'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/18173785/37905775-9964ebb6-3108-11e8-8f98-480cbb1c2906.png
  # /docbuilder/basic
  class BuilderPage
    include PageObject

    DOCUMENTATION = { 'Text document API': {}, 'Spreadsheet API': {}, 'Presentation API': {} }.freeze

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
      DOCUMENTATION.each_key do |editor_name|
        editor = editor_name.downcase.to_s.tr_s(' ', '').to_sym
        editor_xpath = "//*[contains(@href, '#{editor}')]"
        editor_xpath_expend = "(//*[contains(@href, '#{editor}')]/parent::li)[1]/div"
        documentation_xpathes[editor_name] = { xpath: editor_xpath, xpath_expend: editor_xpath_expend }
      end
      documentation_xpathes
    end

    def editors_links_ok?
      checked = check_editors_links
      failed = checked.find_all { |_key, value| value == false }
      [failed.empty?, failed]
    end

    def check_editors_links
      checked = {}
      DOCUMENTATION.each_key do |editor_name|
        checked[editor_name] = @instance.webdriver.element_visible?(@documentation_xpathes[editor_name][:xpath])
      end
      checked
    end
  end
end
