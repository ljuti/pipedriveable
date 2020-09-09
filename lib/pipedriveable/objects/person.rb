require "dry-struct"
require "dry-initializer"

module Types
  include Dry.Types()
end

module Pipedriveable
  module Objects
    class Person
      extend Forwardable
      extend Dry::Initializer

      option :payload, default: proc { Hashie::Mash.new() }

      def_delegators :@data,
        :id,
        :name,
        :first_name,
        :last_name

      def_delegators :@related,
        :organization,
        :user

      attr_reader :phone, :email, :related
        
      def initialize(**payload)
        super
        if payload.has_key?(:payload)
          extract_payload(payload)
          process_phone_numbers
          process_emails
          resolve_related_objects
        else
          initialize_new_object
        end
      end

      def initialize_new_object
        @data = Hashie::Mash.new
      end

      def extract_payload(payload)
        @data = payload[:payload].data
        @related_objects = payload[:payload].related_objects
      end

      def process_phone_numbers
        if @data.respond_to?(:phone)
          @phone = @data.phone.map do |number|
            PhoneNumber.new(
              number: number.value,
              primary: number.primary
            )
          end
        end
      end

      def process_emails
        if @data.respond_to?(:email)
          @email = @data.email.map do |email|
            EmailAddress.new(
              email: email.value,
              primary: email.primary
            )
          end
        end
      end

      def resolve_related_objects
        @related = Hashie::Mash.new
        @related_objects.each do |key, value|
          klass = resolve_klass(key)
          @related.__send__(:"#{key}=", klass.new(payload: value, payload_type: :related))
          @related.__send__(:"#{key}_data=", value)
        end
      end
      
      def resolve_klass(klass)
        case klass
        when "organization"
          Pipedriveable::Objects::Organization
        when "user"
          Pipedriveable::Objects::User
        end
      end
      
      class PhoneNumber < Dry::Struct
        attribute :number, Types::String
        attribute :primary, Types::Bool
      end

      class EmailAddress < Dry::Struct
        attribute :email, Types::String
        attribute :primary, Types::Bool
      end
    end
  end
end