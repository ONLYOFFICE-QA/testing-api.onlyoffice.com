require 'spec_helper'

describe 'document_builder_example' do
  before :all do
    @test_manager = TestingApiOnlyfficeCom::TestManager.new(suite_name: 'Document Builder Example', plan_name: @config.to_s)
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
      file_generated_from_script = @introduction_page.generate_document_from_script
      expect(File.file?(file_generated_from_script)).to be_truthy
      parsed_generated_file = OoxmlParser::Parser.parse(file_generated_from_script)
      expect(parsed_generated_file.elements[2]
                 .character_style_array[0].text).to match(/^ONLYOFFICE.*Commercial director.*/)
    end

    it 'create document works' do
      sample_docx_file = @introduction_page.create_docx_from_sample_data
      expect(File.file?(sample_docx_file)).to be_truthy
      parsed_sample_docx_file = OoxmlParser::Parser.parse(sample_docx_file)
      expect(parsed_sample_docx_file.elements[1]
                 .character_style_array[0].text).to include('John Smith')
      expect(parsed_sample_docx_file.elements[2]
                 .character_style_array[0].text).to match(/^ONLYOFFICE.*Commercial director.*/)
    end

    it 'create spreadsheet works' do
      sample_xlsx_file = @introduction_page.create_xlsx_from_sample_data
      expect(File.file?(sample_xlsx_file)).to be_truthy
      parsed_sample_xlsx_file = OoxmlParser::Parser.parse(sample_xlsx_file)
      expect(parsed_sample_xlsx_file.worksheets[0]
                 .rows[6].cells[0].raw_text).to match(/.*ONLYOFFICE Commercial director.*John Smith.*/)
    end
  end

  after :each do |example|
    @test_manager.add_result(example)
    @instance.webdriver.quit
  end
end
