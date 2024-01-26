# frozen_string_literal: true

require_relative 'doc_builder_method_page/doc_builder_method_params'

module TestingApiOnlyOfficeCom
  # https://github.com/ONLYOFFICE-QA/testing-api.onlyoffice.com/assets/60688343/a813f7c8-09f3-4d12-8b36-5c9d5dfd01cc
  class DocBuilderMethodPage
    include DocBuilderMethodParams

    attr_reader :link, :page, :params_exist, :return_exist, :example_exist, :document_exist

    def initialize(editor, current_class, method)
      @editor = editor
      @current_class = current_class
      @method = method
      @link = "#{Config.new.server}/docbuilder/#{ClassNameHelper.cleanup_name(editor)}/#{ClassNameHelper.cleanup_name(current_class)}/#{ClassNameHelper.cleanup_name(method)}"
      @page = Nokogiri::HTML(URI.parse(@link).open)
      raise(SiteStubsError, 'Method Not Found page') if @page.xpath("//*[@class='layout-content']").text.include?('Method Not Found')

      @params_exist ||= check_params
      @return_exist ||= !@page.xpath('//*[@class="param-type"]').empty?
      @example_exist ||= !@page.xpath('//pre').empty?
      @document_exist ||= sample_document_exists?
      OnlyofficeLoggerHelper.log("Got info #{full_page_name}")
    end

    # @return [String] method signature fetched from page
    def method_signature
      raw_text = @page.xpath('//h4[@class="header-gray"]').text
      raw_text.split("\n")[1].delete(' ').chomp
    end

    # @return [String] full page name
    def full_page_name
      "#{@editor}/#{@current_class}/#{@method}"
    end

    # @return [True, False] is page fully documented
    def fully_documented?
      missing_info.empty?
    end

    # @return [String] missing info for method
    def missing_info
      return @missing_info if @missing_info

      @missing_info = ''
      @missing_info += "#{full_page_name}/Parameters\n" unless @params_exist
      @missing_info += "#{full_page_name}/Example\n" unless @example_exist
      @missing_info += "#{full_page_name}/Returns\n" unless @return_exist
      @missing_info += "#{full_page_name}/Resulting document\n" unless @document_exist
      @missing_info
    end

    private

    # @return [True, False] is sample document exists for this page
    def sample_document_exists?
      !@page.xpath('//*[@class="docbuilder_resulting_docs"]').empty? ||
        !@page.xpath('//*[@id="editorSpace"]').empty?
    end
  end
end
