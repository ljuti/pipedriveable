require "dry-struct"
require "dry-initializer"

module Types
  include Dry.Types()
end

module Pipedriveable
  module Objects
    class Organization < Base
      def_delegators :@data,
        :id,
        :name

      def initialize(**payload)
        super
        if payload.has_key?(:payload)
          extract_payload(payload)
          set_properties
          resolve_related_objects
        else
          initialize_new_object
        end
      end

      def set_properties
        # TODO
      end

      def extract_payload(payload)
        case payload[:payload_type]
        when :api
          @data = payload[:payload].data
        when :related
          key = payload[:payload].keys.first
          @data = payload[:payload][key]
        end
      end

      def resolve_related_objects
        # TODO
      end

      def initialize_new_object
        @data = Hashie::Mash.new
      end
    end
  end
end