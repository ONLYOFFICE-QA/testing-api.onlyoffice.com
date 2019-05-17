require 'onlyoffice_file_helper'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/40513035/57924882-0e894d80-78af-11e9-9ce3-d3f5eb9a2b23.png
  # /docbuilder/basic
  class DocumentationMethodPage
    attr_accessor :link, :page

    def initialize(editor, current_class, method)
      @link = "#{TestingApiOnlyfficeCom::Config.new.server}/docbuilder/#{editor.downcase.tr_s(' ', '')}/#{current_class.downcase.tr_s(' ', '')}/#{method.downcase.tr_s(' ', '')}"
      @page = Nokogiri::HTML(URI.parse(@link).open)
    end

    def all_elements_exist?
      @params_exist ||= !@page.xpath('//*[@class="table"]').empty?
      @return_exist ||= !@page.xpath('//*[@class="param-type"]').empty?
      @example_exist ||= !@page.xpath('//pre').empty?
      @document_exist ||= !@page.xpath('//*[@class="docbuilder_resulting_docs"]').empty?
      @params_exist && @return_exist && @example_exist && @document_exist
    end

    def not_existed_elements
      all_elements_exist?
      not_added_element_array = []
      not_added_element_array << 'Parameters' unless @params_exist
      not_added_element_array << 'Returns' unless @return_exist
      not_added_element_array << 'Example' unless @example_exist
      not_added_element_array << 'Resulting Document' unless @document_exist
      not_added_element_array
    end
  end
end
