# frozen_string_literal: true

require_relative 'test_instance/common_pages'
require_relative 'test_instance/main_page'
module TestingApiOnlyOfficeCom
  # Instance of browser to perform actions
  class TestInstance
    attr_reader :webdriver
    alias selenium webdriver

    def initialize(config)
      @config = config
      @webdriver = OnlyofficeWebdriverWrapper::WebDriver.new(@config.browser)
    end

    # @return [MainPage] main page to operate
    def go_to_main_page
      webdriver.open(@config.server)
      MainPage.new(self)
    end
  end
end
