# frozen_string_literal: true

module TestingApiOnlyOfficeCom
  # module define test data
  module TestData
    # @return [Array<Symbols>]
    DOC_BUILDER_EXAMPLES = %i[
      c_sharp_mvc
      c_sharp
      node_js
      php
      ruby
    ].freeze

    # @return [Array<Symbols>] list of languages with examples
    DOC_SERVER_EXAMPLES = %i[
      c_sharp_mvc
      c_sharp_dotnet
      java
      java_spring
      node_js
      php
      python
      ruby
    ].freeze

    # document builder/generated file name
    DEFAULT_BUILDER_FILE_NAME = 'SampleText.docx'
    DEFAULT_BUILDER_DOCX_FILE_NAME = 'Sample.docx'
    DEFAULT_BUILDER_XLSX_FILE_NAME = 'Sample.xlsx'
    # document builder/data for document generation
    DEFAULT_NAME = 'John Smith'
    DEFAULT_COMPANY = 'ONLYOFFICE'
    DEFAULT_POSITION = 'Commercial director'
    CUSTOM_NAME = 'Ivan Lebedev'
    CUSTOM_COMPANY = 'Heartwell'
    CUSTOM_POSITION = 'QA Engineer'

    def self.workspace_api_backend
      JSON.parse(File.read("#{Dir.pwd}/templates/workspace/api_backend.json"))
    end

    def self.document_builder_usage_api
      JSON.parse(File.read("#{Dir.pwd}/templates/document_builder/usage_api.json"))
    end

    def self.docspace_api_backend
      JSON.parse(File.read("#{Dir.pwd}/templates/docspace/api_backend.json"))
    end
  end
end
