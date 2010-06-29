module Grizzly
  class Configuration
    attr_accessor :logger

    def initialize
      @logger = Grizzly::Logger.new
    end
  end
end