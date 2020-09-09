# frozen_string_literal: true

require "active_support/configurable"

module Pipedriveable
  class Client
    include ActiveSupport::Configurable
    config_accessor :api_token

    def configure
      config.api_token = "api_token"
      self
    end

    def connection
      @connection ||= Pipedriveable::Connection.new(client: self)
    end

    def find(entity:, id:)
      Pipedriveable::Endpoints::Person.new(self).find(id)
    end

    class << self
      def find(entity:, id:)
        case entity

        when :deal
          Pipedriveable::Endpoints::Deal.new(self.new.configure).find(id)
        end
      end
    end
  end
end