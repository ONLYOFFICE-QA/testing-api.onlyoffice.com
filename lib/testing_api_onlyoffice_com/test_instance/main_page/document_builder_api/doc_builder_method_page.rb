# frozen_string_literal: true

module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/40513035/57924882-0e894d80-78af-11e9-9ce3-d3f5eb9a2b23.png
  # /docbuilder/basic
  class DocBuilderMethodPage
    attr_reader :link, :page, :params_exist, :return_exist, :example_exist, :document_exist

    def initialize(editor, current_class, method)
      @editor = editor
      @current_class = current_class
      @method = method
      @link = "#{Config.new.server}/docbuilder/#{ClassNameHelper.cleanup_name(editor)}/#{ClassNameHelper.cleanup_name(current_class)}/#{ClassNameHelper.cleanup_name(method)}"
      @page = Nokogiri::HTML(URI.parse(@link).open)
      @params_exist ||= !@page.xpath('//*[@class="table"]').empty?
      @return_exist ||= !@page.xpath('//*[@class="param-type"]').empty?
      @example_exist ||= !@page.xpath('//pre').empty?
      @document_exist ||= sample_document_exists?
      OnlyofficeLoggerHelper.log("Got info about #{full_page_name} page")
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
