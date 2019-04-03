require 'onlyoffice_file_helper'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/18173785/37905775-9964ebb6-3108-11e8-8f98-480cbb1c2906.png
  # /docbuilder/basic
  module LeftSideNavigationBuilder
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
  end
end
