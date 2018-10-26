module TestingApiOnlyfficeCom
  # Config of running tests
  class Config
    # @return [String] server url
    attr_reader :server
    # @return [Symbol] browser
    attr_reader :browser

    def initialize(params = {})
      @server = params.fetch(:server, 'https://api.teamlab.info')
      @browser = params.fetch(:browser, :chrome)
    end

    # @return [String] metadata of confg
    def to_s
      "#{@server}, Version: #{server_version}, Browser: #{@browser}"
    end

    private

    # @return [String] version of server
    def server_version
      "Unknown by #{Time.now.strftime('%d/%m/%Y %H:%M')}"
    end
  end
end
