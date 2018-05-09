require 'ifttt_push/configuration'
require 'net/http'
require 'json'

class IftttPush
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end

  attr_reader :title, :message, :link_url
  attr_accessor :callbacks

  def initialize(title:, message:, link_url:)
    @title = title
    @message = message
    @link_url = link_url
    @callbacks = []
  end

  def push!
    body = {
      value1: title,
      value2: message,
      value3: link_url
    }

    uri = URI.parse('https://maker.ifttt.com:80/trigger/push_notification/with/key/' + self.class.configuration.key)
    http = Net::HTTP.new(uri.host, uri.port)

    http.post(uri.path, body.to_json, "Content-Type" => "application/json").tap do |_response|
      callbacks.each(&:call)
    end
  end

  def on_complete(&block)
    callbacks << block
    self
  end
end