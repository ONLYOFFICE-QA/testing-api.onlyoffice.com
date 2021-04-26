# frozen_string_literal: true

module TestingApiOnlyfficeCom
  # Module for search left sidebar
  module SearchSidebar
    # @return [String] xpath for search input
    def xpath_search_input
      '//div[contains(@class, "search-input")]//input'
    end

    # Perform search by string
    # @param [String] string to find
    # @return [SearchResultPage] page with result
    def search(string)
      @instance.webdriver.type_text(xpath_search_input, "#{string}\n")
      SearchResultPage.new(@instance)
    end

    # @return [String] text in search input value
    def search_input_value
      @instance.webdriver.get_text(xpath_search_input)
    end
  end
end
