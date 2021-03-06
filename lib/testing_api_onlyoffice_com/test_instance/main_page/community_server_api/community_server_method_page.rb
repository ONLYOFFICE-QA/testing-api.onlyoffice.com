# frozen_string_literal: true

module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/40513035/57924882-0e894d80-78af-11e9-9ce3-d3f5eb9a2b23.png
  # portals/basic
  class CommunityServerMethodPage
    attr_reader :link, :page, :params_exist, :return_exist, :example_exist, :document_exist

    def initialize(current_module, method)
      @link = "#{Config.new.server}/portals/method/#{ClassNameHelper.cleanup_name(current_module)}/#{ClassNameHelper.cleanup_name(method)}"
      @page = Nokogiri::HTML(URI.parse(@link).open)
      @params_exist ||= !@page.xpath('//div[@id="methodParams"]').empty?
      @example_exist ||= !@page.xpath('//div[@id="methodExample"]/pre').empty?
      @return_exist ||= !@page.xpath('//div[@id="methodReturns"]/p/text()').empty?
      @document_exist ||= !@page.xpath('//div[@id="methodResponse"]/pre').empty?
    end
  end
end
