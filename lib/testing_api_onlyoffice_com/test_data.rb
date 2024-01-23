# frozen_string_literal: true

module TestingApiOnlyOfficeCom
  # module define test data
  module TestData
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

    def self.community_server_api_backend
      File.read("#{Dir.pwd}/templates/community_server/api_backend.json")
    end

    def self.document_builder_usage_api
      File.read("#{Dir.pwd}/templates/document_builder/usage_api.json")
    end

    def self.docspace_api_backend
      JSON.parse(File.read("#{Dir.pwd}/templates/docspace/api_backend.json"))
    end
  end
end
