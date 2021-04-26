# frozen_string_literal: true

module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/668524/116047440-c1a67800-a67c-11eb-9ab2-527ac3547f2c.png
  # https://api.teamlab.info/portals/search?query=mysearch
  class SearchResultPage
    include SearchSidebar
    def initialize(instance)
      @instance = instance
      wait_to_load
    end

    # Wait for page to load
    # @return [nil]
    def wait_to_load
      @instance.webdriver.wait_until do
        no_entries_found? || some_entries_found?
      end
    end

    # @return [Boolean] is no entries found
    def no_entries_found?
      @instance.webdriver.element_visible?(no_result_found_xpath)
    end

    # @return [Boolean] is some entries found
    def some_entries_found?
      @instance.webdriver.element_visible?(search_result_entry_xpath)
    end

    # @return [Integer] found entries count
    def search_result_count
      return 0 if no_entries_found?

      @instance.webdriver.get_element_count(search_result_entry_xpath)
    end

    private

    # @return [String] no result found message xpath
    def no_result_found_xpath
      "//span[text() = 'No results found']"
    end

    # @return [String] xpath of search result entry
    def search_result_entry_xpath
      "//span[text() = 'Search results']/../..//tbody//tr"
    end
  end
end
