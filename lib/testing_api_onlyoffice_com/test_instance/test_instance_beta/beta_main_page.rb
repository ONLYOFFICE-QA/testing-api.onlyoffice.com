# frozen_string_literal: true

require_relative '../main_page'
require_relative 'beta_main_page/beta_docspace/beta_docspace_main'
require_relative 'beta_main_page/beta_docspace/beta_javascript_sdk'
require_relative 'beta_main_page/beta_docspace/beta_plugins_sdk'
require_relative 'beta_main_page/beta_docspace/beta_api_backend'
require_relative 'beta_main_page/beta_docspace/beta_for_hosting_providers'

module TestingApiOnlyOfficeCom
  # Main page of BETA api.onlyoffice.com
  # TODO: screen
  class BetaMainPage
    include PageObject

    attr_accessor :instance

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    form(:search, xpath: "*//form[contains(@id, 'search')]")
    link(:b_old_version, xpath: "*//div[contains(@class, 'page-header__legacy')]/legacy-container/a[contains(text(), 'Old version')]")
    link(:docspace, xpath: "*//a[contains(@class, 'global-navigation__menu-link') and contains(@href, 'docspace')]")
    link(:javascript_sdk, xpath: "*//a[contains(@class, 'global-navigation__submenu-link') and contains(@href, 'docspace') and contains(@href, 'javascript-sdk')]")
    link(:plugins_sdk, xpath: "*//a[contains(@class, 'global-navigation__submenu-link') and contains(@href, 'docspace') and contains(@href, 'plugins-sdk')]")
    link(:api_backend, xpath: "*//a[contains(@class, 'global-navigation__submenu-link') and contains(@href, 'docspace') and contains(@href, 'api-backend')]")
    link(:for_hosting_providers, xpath: "*//a[contains(@class, 'global-navigation__submenu-link') and contains(@href, 'docspace') and contains(@href, 'for-hosting-providers')]")

    def wait_to_load
      @instance.webdriver.wait_until do
        search_element.present?
      end
    end

    def go_to_old_via_cookie
      @instance.webdriver.driver.manage.delete_cookie('X-OO-API')
      @instance.webdriver.driver.navigate.refresh
    end

    def go_to_beta_docspace
      docspace_element.when_visible.click
      BetaDocSpaceMainPage.new(@instance)
    end

    def go_to_beta_javascript_sdk
      action_move_to(docspace_element.element.selector[:xpath])
      javascript_sdk_element.when_visible.click
      BetaJavaScriptSDK.new(@instance)
    end

    def go_to_beta_plugins_sdk
      action_move_to(docspace_element.element.selector[:xpath])
      plugins_sdk_element.when_visible.click
      BetaPluginsSDK.new(@instance)
    end

    def go_to_beta_api_backend
      action_move_to(docspace_element.element.selector[:xpath])
      api_backend_element.when_visible.click
      BetaApiBackend.new(@instance)
    end

    def go_to_beta_for_hosting_providers
      action_move_to(docspace_element.element.selector[:xpath])
      for_hosting_providers_element.when_visible.click
      BetaForHostingProviders.new(@instance)
    end

    # @return [Object]
    def all_cookies
      @instance.webdriver
               .driver
               .manage.all_cookies
    end

    def action_move_to(xpath)
      element = @instance.webdriver.driver.find_element(:xpath, xpath)
      action = @instance.webdriver.driver.action
      action.move_to(element).perform
    end
  end
end
