# frozen_string_literal: true

module TestingApiOnlyfficeCom
  # Config of running tests
  class Config
    # @return [String] server url
    attr_reader :server
    # @return [Symbol] browser
    attr_reader :browser

    def initialize(params = {})
      @server = params.fetch(:server, default_server)
      @browser = params.fetch(:browser, :chrome)
    end

    # @return [String] metadata of confg
    def to_s
      "#{@server}, Version: #{server_version}, Browser: #{@browser}"
    end

    private

    # @return [String] version of server
    def server_version
      version = URI.parse("#{@server}/version.txt").open.read.chomp
      return "Unknown by #{Time.now.strftime('%d/%m/%Y %H:%M')}" unless version =~ /^[[:xdigit:]]+$/

      version
    end

    # @return [String] server on which test are performed
    def default_server
      return 'https://api.onlyoffice.com' if ENV.fetch('SPEC_REGION', 'unknown').include?('com')

      'https://api.teamlab.info'
    end
  end
end
