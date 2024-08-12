# frozen_string_literal: true

require_relative '../main_page'

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

    def wait_to_load
      @instance.webdriver.wait_until do
        search_element.present?
      end
    end

    def go_to_old_via_cookie
      @instance.webdriver.driver.manage.delete_cookie('X-OO-API')
      @instance.webdriver.driver.navigate.refresh
    end

    # @return [Object]
    def all_cookies
      @instance.webdriver
               .driver
               .manage.all_cookies
    end
  end
end
