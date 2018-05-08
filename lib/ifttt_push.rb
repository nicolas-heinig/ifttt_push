require 'ifttt_push/configuration'
require 'net/http'
require 'json'

module IftttPush
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    def notify(title:, message:, link_url:)
      body = {
        value1: title,
        value2: message,
        value3: link_url
      }

      uri = URI.parse('https://maker.ifttt.com:80/trigger/push_notification/with/key/' + self.configuration.key)
      http = Net::HTTP.new(uri.host, uri.port)

      http.post(uri.path, body.to_json, "Content-Type" => "application/json")
    end
  end
end