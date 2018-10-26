require 'onlyoffice_tcm_helper'
require_relative 'helpers/palladium_helper'
module TestingApiOnlyfficeCom
  # this class help to init palladium and test case manager helper
  class TestManager
    include PalladiumHelper

    def initialize(params = {})
      params[:suite_name] ||= File.basename(__FILE__)
      params[:plan_name] ||= 'Unknown Plan Name'
      params[:product_name] ||= 'api.onlyoffice.com'
      @tcm_helper = OnlyofficeTcmHelper::TcmHelper.new(params)
      @palladium = init_palladium(@tcm_helper)
    end

    def add_result(example)
      result = @tcm_helper.parse(example)
      @palladium.set_result(status: result.status.to_s, description: result.result_message, name: result.case_name)
    end
  end
end
