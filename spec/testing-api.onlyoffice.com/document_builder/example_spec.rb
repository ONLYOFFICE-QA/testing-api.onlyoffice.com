# frozen_string_literal: true

require 'spec_helper'
describe 'document_builder_example' do
  test_manager = TestingApiOnlyOfficeCom::TestManager.new(suite_name: 'Document Builder Example', plan_name: config.to_s)

  before do
    @instance = TestingApiOnlyOfficeCom::TestInstance.new(config)
    @api_page = @instance.go_to_main_page
  end

  after do |example|
    test_manager.add_result(example)
    @instance.webdriver.quit
  end

  describe 'document_builder_generate_on_introduction_page' do
    before do
      @introduction_page = @api_page.go_to_document_builder_introduction
    end

    it 'generate document on introduction page works' do
      file_generated_from_script = @introduction_page.generate_document_from_script
      expect(File).to be_file(file_generated_from_script)
      parsed_generated_file = OoxmlParser::Parser.parse(file_generated_from_script)
      expect(parsed_generated_file.elements[2]
                 .character_style_array[0].text).to match(/^#{TestData::DEFAULT_COMPANY}.*#{TestData::DEFAULT_POSITION}.*/)
    end

    it 'create document on introduction page works' do
      sample_docx_file = @introduction_page.create_docx_from_sample_data
      expect(File).to be_file(sample_docx_file)
      parsed_sample_docx_file = OoxmlParser::Parser.parse(sample_docx_file)
      expect(parsed_sample_docx_file.elements[1]
                 .character_style_array[0].text).to include(TestData::DEFAULT_NAME)
      expect(parsed_sample_docx_file.elements[2]
                 .character_style_array[0].text).to match(/^#{TestData::DEFAULT_COMPANY}.*#{TestData::DEFAULT_POSITION}.*/)
    end

    it 'create spreadsheet on introduction page works' do
      sample_xlsx_file = @introduction_page.create_xlsx_from_sample_data
      expect(File).to be_file(sample_xlsx_file)
      parsed_sample_xlsx_file = OoxmlParser::Parser.parse(sample_xlsx_file)
      expect(parsed_sample_xlsx_file.worksheets[0]
                 .rows[6].cells[0].raw_text)
        .to match(/.*#{TestData::DEFAULT_COMPANY} #{TestData::DEFAULT_POSITION}.*#{TestData::DEFAULT_NAME}.*/)
    end

    it 'create document with custom data on introduction page works' do
      @introduction_page.input_name_company_position
      sample_docx_custom_file = @introduction_page.create_docx_from_sample_data
      parsed_sample_custom_docx_file = OoxmlParser::Parser.parse(sample_docx_custom_file)
      expect(parsed_sample_custom_docx_file.elements[1]
                 .character_style_array[0].text).to include(TestData::CUSTOM_NAME)
      expect(parsed_sample_custom_docx_file.elements[2]
                 .character_style_array[0].text).to match(/^#{TestData::CUSTOM_COMPANY}.*#{TestData::CUSTOM_POSITION}.*/)
    end

    it 'create spreadsheet with custom data on introduction page works' do
      @introduction_page.input_name_company_position
      sample_xlsx_custom_file = @introduction_page.create_xlsx_from_sample_data
      parsed_sample_custom_xlsx_file = OoxmlParser::Parser.parse(sample_xlsx_custom_file)
      expect(parsed_sample_custom_xlsx_file.worksheets[0]
                 .rows[6].cells[0].raw_text)
        .to match(/.*#{TestData::CUSTOM_COMPANY} #{TestData::CUSTOM_POSITION}.*#{TestData::CUSTOM_NAME}.*/)
    end
  end
end
