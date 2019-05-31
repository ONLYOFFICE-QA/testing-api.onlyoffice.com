# frozen_string_literal: true

require_relative 'class_name_helper'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/40513035/56642044-4c63cf00-667f-11e9-935f-0d275d601876.png
  # /docbuilder/basic
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

    def visible?
      @instance.webdriver.element_visible?(@xpath)
    end

    def [](var)
      if var.is_a?(String)
        @children.detect do |child|
          child.name == ClassNameHelper.cleanup_name(var)
        end
      elsif var.is_a?(Numeric)
        @children[var]
      end
    end
  end
end
