# frozen_string_literal: true

require_relative 'document_builder_api_common/builder_page'

module TestingApiOnlyOfficeCom
  # https://github.com/ONLYOFFICE-QA/testing-api.onlyoffice.com/assets/60688343/9bb5c42a-2bde-4bb3-97c6-cd70d7fcfdd9
  # /docbuilder/gettingstarted
  class DocumentBuilderGettingStarted < BuilderPage
    elements(:layout_table_footer_links, xpath: '//a[contains(@target, "_blank")]')

    def initialize(instance)
      @instance = instance
      @logger = Logger.new($stdout)
      @logger.level = Logger::INFO
      super
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { layout_table_footer_links_elements[0].present? }
    end

    def footer_links
      result = {}
      layout_table_footer_links_elements.each do |element|
        result.merge!("#{element.href}": element.visible?)
      end
      result
    end

    def survey_of_external_links
      result = {}
      layout_table_footer_links_elements.each do |element|
        uri = URI(element.href)
        res = Net::HTTP.get_response(uri)
        @logger.info("#{uri}: #{res.code}")
        result.merge!("#{uri}": res.code)
      end
    end
  end
end
