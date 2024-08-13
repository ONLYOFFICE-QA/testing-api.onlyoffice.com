# frozen_string_literal: true

require_relative '../main_page'
require_relative 'beta_main_page/beta_docspace_main'
require_relative 'beta_main_page/beta_javascript_sdk'

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
