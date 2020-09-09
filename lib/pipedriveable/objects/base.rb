require "dry-struct"
require "dry-initializer"

module Types
  include Dry.Types()
end

module Pipedriveable
  module Objects
    class Base
      extend Forwardable
      extend Dry::Initializer

      option :payload, default: proc { Hashie::Mash.new() }
      option :payload_type, default: proc { :api }

      def extract_payload(payload)
        case payload[:payload_type]
        when :api
          @data = payload[:payload].data
        when :related
          key = payload[:payload].keys.first
          @data = payload[:payload][key]
        end
      end

    end
  end
end