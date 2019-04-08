require 'spec_helper'

describe 'document_builder_example' do
  before :all do
    @test_manager = TestingApiOnlyfficeCom::TestManager.new(suite_name: 'Site Api', plan_name: @config.to_s)
  end

  before :each do
    @instance = TestingApiOnlyfficeCom::TestInstance.new(@config)
    @api_page = @instance.go_to_main_page
  end

  describe 'document_builder_generate' do
    before :each do
      @introduction_page = @api_page.go_to_document_builder_introduction
    end

    it 'generate document works' do
      builder_download = @introduction_page.builder_download
      expect(File.file?(builder_download)).to be_truthy
      parser_builder = OoxmlParser::Parser.parse(builder_download)
      builder_text = parser_builder.elements[2].character_style_array[0].text
      /^ONLYOFFICE.*Commercial director.*/.match?(builder_text)
    end

    it 'create document works' do
      docx_download = @introduction_page.builder_docx_download
      expect(File.file?(docx_download)).to be_truthy
      parser_docx = OoxmlParser::Parser.parse(docx_download)
      docx_name = parser_docx.elements[1].character_style_array[0].text
      docx_company_and_position = parser_docx.elements[2].character_style_array[0].text
      expect(docx_name).to include('John Smith')
      /^ONLYOFFICE.*Commercial director.*/.match?(docx_company_and_position)
    end

    it 'create spreadsheet works' do
      xlsx_download = @introduction_page.builder_xlsx_download
      expect(File.file?(xlsx_download)).to be_truthy
      parser_xlsx = OoxmlParser::Parser.parse(xlsx_download)
      xlsx_name_company_position = parser_xlsx.worksheets[0].rows[6].cells[0].raw_text
      /.*ONLYOFFICE Commercial director.*John Smith.*/.match?(xlsx_name_company_position)
    end
  end

  after :each do |example|
    @test_manager.add_result(example)
    @instance.webdriver.quit
  end
end
