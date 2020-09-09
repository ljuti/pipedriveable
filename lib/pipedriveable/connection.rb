# frozen_string_literal: false

require "faraday"
require "faraday_middleware"

module Pipedriveable
  class Connection

    def initialize(client: Pipedriveable::Client.new)
      @client = client
      raise ArgumentError.new("You must set Pipedrive API token") unless api_token.present?
    end

    def api_token
      @token ||= @client.config.api_token
    end

    def connection
      @connection ||= Faraday.new(faraday_options) do |connection|
        connection.request :url_encoded
        connection.response :mashify
        connection.response :json, content_type: /\bjson$/

        connection.adapter Faraday.default_adapter
      end
    end

    def call(options)
      url = build_url(action: options.fetch(:action), entity: options.fetch(:entity))
      begin
        result = connection.__send__(:get, url)
      rescue Errno::ETIMEDOUT
        retry
      rescue Faraday::ParsingError
        sleep 5
        retry
      end

      process_response(result)
    end

    def process_response(result)
      if result.success?
        data = if result.body.is_a?(::Hashie::Mash)
          result.body.merge(success: true)
        else
          ::Hashie::Mash.new(success: true)
        end
        return data
      end
      failed_response(result)
    end

    private

    def build_url(action:, entity:)
      url = "/v1/#{entity_resource(entity)}"
      url << "?api_token=#{api_token}"
      url
    end

    def entity_resource(entity)
      case entity
      when :person
        "persons"
      else
        entity.to_s.pluralize
      end
    end

    def user_agent
      @user_agent ||= "Pipedriveable Ruby Client :: v#{::Pipedriveable::VERSION}"
    end

    def faraday_options
      {
        url: "https://api.pipedrive.com",
        headers: {
          accept: "application/json",
          user_agent: user_agent
        }
      }
    end

  end
end