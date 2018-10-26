require_relative 'test_instance/main_page'
module TestingApiOnlyfficeCom
  # Instance of browser to perform actions
  class TestInstance
    attr_reader :webdriver
    alias selenium webdriver

    def initialize(config)
      @webdriver = OnlyofficeWebdriverWrapper::WebDriver.new(config.browser)
    end

    # @return [MainPage] main page to operate
    def go_to_main_page
      webdriver.open('https://api.teamlab.info') # TODO: Add support of api.onlyoffice.com
      MainPage.new(self)
    end
  end
end
