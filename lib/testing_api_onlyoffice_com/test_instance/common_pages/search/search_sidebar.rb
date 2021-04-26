# frozen_string_literal: true

module TestingApiOnlyfficeCom
  # Module for search left sidebar
  module SearchSidebar
    # Perform search by string
    # @param [String] string to find
    # @return [SearchResultPage] page with result
    def search(string)
      @instance.webdriver.type_text('//div[contains(@class, "search-input")]//input', "#{string}\n")
      SearchResultPage.new(@instance)
    end
  end
end
