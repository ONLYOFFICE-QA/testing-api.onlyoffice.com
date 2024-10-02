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

    def click_by_a_via_href(arg = '')
      xpath = "//a[@href='#{@link}' #{arg}]"
      element = @instance.webdriver.get_element(xpath)
      if xpath.include?('constructor')
        button = element.find_element(:xpath, './../../../../div/button')
        @instance.webdriver.click(button)
      elsif parent_element_exists?(element, :xpath, './../../../../div/span') &&
            parent_element_exists?(element, :xpath, "./../../../../div[contains(@class, 'tree__twig_closed')]")
        element.find_element(:xpath, './../../../../div/button').click
      end
      @instance.webdriver.click(element)
      self
    end

    # Method to check if an element exists
    def parent_element_exists?(element, by, locator)
      element.find_element(by, locator)
      true
    rescue Selenium::WebDriver::Error::NoSuchElementError
      false
    end

    def all_img_exists?
      # Find all image elements
      images = @instance.webdriver.driver.find_elements(:tag_name, 'img')

      # literal [] is overloaded
      result = Array.new

      # Iterate through each image and check its status
      images.each do |image|
        src = image.attribute('src')

        if src
          begin
            # Make an HTTP request to the image URL
            uri = URI.parse(src)
            response = Net::HTTP.get_response(uri)

            # Print the status of each image
            if response.code.to_i == 200
              OnlyofficeLoggerHelper.log "Image loaded successfully: #{src}"
              result.push(true)
            else
              OnlyofficeLoggerHelper.log "Image failed to load (status code: #{response.code}): #{src}"
              result.push(false)
            end
          rescue CheckImageError => e
            OnlyofficeLoggerHelper.log "Error checking image: #{src}. Error: #{e.message}"
            result.push(false)
          end
        else
          OnlyofficeLoggerHelper.log 'Image element without a source.'
          result.push(false)
        end
      end
      result
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
      else
        StandardError 'No children found'
      end
    end
  end
end
