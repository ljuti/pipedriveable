require "dry-struct"

module Types
  include Dry.Types()
end

module Pipedriveable
  module Entities
    class Person < Dry::Struct
      class PhoneNumber < Dry::Struct
        attribute :number, Types::String.optional
        attribute :primary, Types::Bool
      end

      attribute :first_name, Types::String
      attribute :last_name, Types::String
      attribute :phones, Types::Array do
        attribute :number, Types::String
        attribute :primary, Types::Bool
      end

    end
  end
end