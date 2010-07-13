module Grizzly
  class Configuration
    attr_accessor :logger
    attr_writer :redis_port
    attr_writer :redis_host

    def initialize
      @logger = Grizzly::Logger.new
    end
    
  end
end