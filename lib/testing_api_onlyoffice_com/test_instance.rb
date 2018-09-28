require_relative 'test_instance/main_page'
module TestingApiOnlyfficeCom
  class TestInstance
    attr_reader :webdriver
    alias selenium webdriver

    def initialize(browser = :chrome)
      @webdriver = OnlyofficeWebdriverWrapper::WebDriver.new(browser)
    end

    def go_to_main_page
      webdriver.open('https://api.teamlab.info') # TODO: Add support of api.onlyoffice.com
      MainPage.new(self)
    end
  end
end
