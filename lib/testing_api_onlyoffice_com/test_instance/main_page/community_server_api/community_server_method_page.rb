# frozen_string_literal: true

module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/40513035/57924882-0e894d80-78af-11e9-9ce3-d3f5eb9a2b23.png
  # portals/basic
  class CommunityServerMethodPage
    attr_reader :link, :page, :params_exist, :return_exist, :example_exist, :document_exist

    def initialize(current_module, method)
      @module = current_module
      @method = method
      @link = "#{Config.new.server}/portals/method/#{ClassNameHelper.cleanup_name(current_module)}/#{ClassNameHelper.cleanup_name(method)}"
      @page = Nokogiri::HTML(URI.parse(@link).open)
      raise(SiteStubsError, 'Method Not Found page') if @page.xpath("//*[@class='layout-content']").text.include?('Method Not Found')

      @params_exist ||= !@page.xpath('//div[@id="methodParams"]').empty?
      @example_exist ||= !@page.xpath('//div[@id="methodExample"]/pre').empty?
      @return_exist ||= !@page.xpath('//div[@id="methodReturns"]/p/text()').empty?
      @document_exist ||= !@page.xpath('//div[@id="methodResponse"]/pre').empty?
      OnlyofficeLoggerHelper.log("Got info about #{full_page_name} page")
    end

    # @return [String] full page name
    def full_page_name
      "#{@module}/#{@method}"
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
  end
end
