require "dry-struct"
require "dry-initializer"

module Types
  include Dry.Types()
end

module Pipedriveable
  module Objects
    class User < Base
      def_delegators :@data,
        :id,
        :name

      def initialize(**payload)
        super

        if payload.has_key?(:payload)
          extract_payload(payload)
        end
      end
    end
  end
end