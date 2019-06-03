# frozen_string_literal: true

module TestingApiOnlyfficeCom
  # module for initialise palladium object
  module PalladiumHelper
    def init_palladium(tcm_helper)
      Palladium.new(host: 'palladium.teamlab.info',
                    token: palladium_token,
                    product: tcm_helper.product_name,
                    plan: tcm_helper.plan_name,
                    run: tcm_helper.suite_name)
    rescue StandardError => e
      OnlyofficeLoggerHelper.log("Cant init palladium. Error: #{e}", 41)
    end

    def palladium_token
      palladium_key = ENV['ONLYOFFICE_PALLADIUM_KEY'] || File.read("#{ENV['HOME']}/.palladium/token")
      raise 'Palladium key not found' unless palladium_key

      palladium_key
    end
  end
end
