# frozen_string_literal: true

require_relative 'document_builder_api_common/builder_page'

module TestingApiOnlyOfficeCom
  # https://github.com/ONLYOFFICE-QA/testing-api.onlyoffice.com/assets/60688343/9bb5c42a-2bde-4bb3-97c6-cd70d7fcfdd9
  # /docbuilder/gettingstarted
  class DocumentBuilderGettingStarted < BuilderPage
    # External link to docbuilder lib sources
    elements(:links_native_documentbuidler, xpath: '//a[contains(@href, "builder.aspx")]')

    def initialize(instance)
      @instance = instance
      super
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { links_native_documentbuidler_elements[0].present? }
    end

    def external_links_succeeded?
      result = []
      links_native_documentbuidler_elements.each do |element|
        result.push element.visible?
        @instance.webdriver.webdriver_error('Not visible element for external link') unless result[-1]
        uri = URI(element.href)
        res = Net::HTTP.get_response(uri)
        result.push res.code.include? '200'
      end
      result.all?
    end
  end
end
