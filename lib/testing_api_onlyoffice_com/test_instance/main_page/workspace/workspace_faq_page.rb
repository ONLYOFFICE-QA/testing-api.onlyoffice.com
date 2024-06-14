# frozen_string_literal: true

module TestingApiOnlyOfficeCom
  # https://github.com/ONLYOFFICE-QA/testing-api.onlyoffice.com/assets/60688343/28a0e03f-5001-40e9-9b49-e3892e7d19cf
  # Class for `https://api.teamlab.info/portals/workspaceapi/faq`
  class WorkspaceFaqPage
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
