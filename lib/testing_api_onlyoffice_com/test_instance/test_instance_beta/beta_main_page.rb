# frozen_string_literal: true

require_relative '../main_page'
require_relative '../documentation_helper/chapter_nav_parser'
require_relative 'beta_main_page/beta_docs'
require_relative 'beta_main_page/beta_docspace'
require_relative 'beta_main_page/beta_workspace'

module TestingApiOnlyOfficeCom
  # Main page of BETA api.onlyoffice.com
  # https://github.com/user-attachments/assets/eb2385e5-fec6-4b02-8435-d7b99090ec32
  class BetaMainPage
    include PageObject

    attr_accessor :instance

    def initialize(instance)
      @instance = instance
      super(@instance.webdriver.driver)
      wait_to_load
    end

    form(:search, xpath: "*//form[contains(@id, 'search')]")
    link(:docspace, xpath: "*//a[contains(@class, 'global-navigation__menu-link') and contains(@href, 'docspace')]")
    link(:b_old_version, xpath: "*//div[contains(@class, 'page-header__legacy')]/legacy-container/a[contains(text(), 'Old version')]")
    link(:docspace, xpath: "*//a[contains(@class, 'global-navigation__menu-link') and contains(@href, 'docspace')]")
    link(:docs, xpath: "*//a[contains(@class, 'global-navigation__menu-link') and contains(@href, 'docs/')]")
    link(:workspace, xpath: "*//a[contains(@class, 'global-navigation__menu-link') and contains(@href, 'workspace/')]")
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

    def go_to_beta_docspace
      docspace_element.when_visible.click
      BetaDocSpace.new(@instance)
    end

    def go_to_beta_docs
      docs_element.when_visible.click
      BetaDocs.new(@instance)
    end

    def go_to_beta_workspace
      workspace_element.when_visible.click
      BetaWorkspace.new(@instance)
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
