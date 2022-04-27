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
      return ENV.fetch('PALLADIUM_TOKEN') if ENV.key?('PALLADIUM_TOKEN')

      token_file = "#{Dir.home}/.palladium/token"
      return File.read(token_file) if File.exist?(token_file)

      raise 'Palladium key not found'
    end
  end
end
