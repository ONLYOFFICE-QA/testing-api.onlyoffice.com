# frozen_string_literal: true

module TestingApiOnlyfficeCom
  # Module with methods to handle DocBuilder method params
  module DocBuilderMethodParams
    # @return [True, false] is method has no params
    def without_params?
      method_signature.end_with?('()')
    end

    # @return [Boolean] is params are correctly present on page
    def check_params
      return correct_message_no_params? if without_params?

      !@page.xpath('//*[@class="table"]').empty?
    end

    # @return [Boolean] is page contains correct message for no params
    def correct_message_no_params?
      @page.xpath('//*[@id="methodParams"]').text == "This method doesn't have any parameters."
    end
  end
end
