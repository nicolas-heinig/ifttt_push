require 'ifttt_push/configuration'

module IftttPush
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    def notify
    end
  end
end