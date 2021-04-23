# frozen_string_literal: true

module TestingApiOnlyfficeCom
  # Module with methods to handle DocBuilder method params
  module DocBuilderMethodParams
    # @return [True, false] is method has no params
    def without_params?
      method_signature.end_with?('()')
    end

    def check_params
      @page.xpath('//*[@id="methodParams"]').text == "This method doesn't have any parameters." if without_params?

      !@page.xpath('//*[@class="table"]').empty?
    end
  end
end
