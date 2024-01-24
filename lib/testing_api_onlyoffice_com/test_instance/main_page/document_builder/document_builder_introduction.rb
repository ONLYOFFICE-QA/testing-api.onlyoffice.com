# frozen_string_literal: true

require_relative 'document_builder_api_common/document_builder'
require_relative 'document_builder_api_common/builder_page'

module TestingApiOnlyOfficeCom
  # https://github.com/ONLYOFFICE-QA/testing-api.onlyoffice.com/assets/60688343/76b71ee9-b9d6-4259-a030-5883fe75e042
  # /docbuilder/basic
  class DocumentBuilderIntroduction < BuilderPage
    include DocumentBuilder

    def initialize(instance)
      @instance = instance
      super
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { button_generate_document_visible? }
    end
  end
end
