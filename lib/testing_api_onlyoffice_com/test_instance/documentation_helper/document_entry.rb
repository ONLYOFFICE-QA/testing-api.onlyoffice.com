# frozen_string_literal: true

require_relative 'class_name_helper'
module TestingApiOnlyOfficeCom
  # Class containing html list traversal logic
  class DocumentEntry
    attr_accessor :link, :xpath, :xpath_expend, :children
    attr_reader :name

    def initialize(instance, link, current_object)
      @instance = instance
      @link = ClassNameHelper.cleanup_name(link)
      @xpath = "//*[contains(@href, '#{@link}')]"
      @xpath_expend = "(#{@xpath}/parent::li)[1]/div"
      @children = []
      @name = ClassNameHelper.cleanup_name(current_object)
    end

    def click_expend
      element = @instance.webdriver.get_element(@xpath_expend)
      @instance.webdriver.click(element)
      # wait until expended lists of classes are opened
      sleep 2
    end

    # @return [Integer] child count on page
    def child_count_on_page
      child_xpath = "#{@xpath}/../ul/li[not(contains(@class, 'collapsable')) and not(contains(@class, 'expandable'))]"
      if child_xpath.include?('/unspecified')
        child_xpath = child_xpath.gsub('/unspecified', '')
        child_xpath = "//ul[contains(@class, 'side-nav')]/li#{child_xpath.gsub('//*', '/a')}"
      end
      @instance.webdriver.get_element_count(child_xpath)
    end

    def visible?
      @instance.webdriver.element_visible?(@xpath)
    end

    def [](var)
      case var
      when String
        @children.detect do |child|
          child.name == ClassNameHelper.cleanup_name(var)
        end
      when Numeric
        @children[var]
      end
    end
  end
end
