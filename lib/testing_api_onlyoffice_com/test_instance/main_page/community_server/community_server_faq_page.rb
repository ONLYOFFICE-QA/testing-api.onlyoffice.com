# frozen_string_literal: true

module TestingApiOnlyOfficeCom
  # https://user-images.githubusercontent.com/668524/146583286-eddeaf82-a560-4e56-a79c-d87c1ccf043c.png
  # Class for `https://api.onlyoffice.com/portals/faq` page
  class CommunityServerFaqPage
    def initialize(instance)
      @instance = instance
      wait_to_load
    end

    # Check if page is loaded
    # @return [Boolean] result of that check
    def loaded?
      @instance.webdriver.element_visible?('//*[@id="community_1"]')
    end

    # Wait until page is loaded
    def wait_to_load
      @instance.webdriver.wait_until { loaded? }
    end
  end
end
