require 'logger'

module Grizzly
  class Logger < Logger
    ##
    # Create a new logger. Works like Logger from Ruby's standard library, but
    # defaults to STDOUT instead of failing. You can pass a filename to log to.
    #
    # @param [String] logdev a filename to log to, defaults to STDOUT
    #
    # @example
    #   logger = Grizzly::Logger.new
    #   logger = Grizzly::Logger.new('~/file.log')

    def initialize(logdev = STDOUT)
      super logdev
    end    
  end
end
