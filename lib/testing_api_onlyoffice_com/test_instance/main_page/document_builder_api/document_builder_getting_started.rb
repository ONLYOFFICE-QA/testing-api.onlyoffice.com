# frozen_string_literal: true

require_relative 'document_builder_api_common/builder_page'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/60688343/234644612-b4cd4a13-0f80-4de6-a7da-f5dcc3e3e051.jpg
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
