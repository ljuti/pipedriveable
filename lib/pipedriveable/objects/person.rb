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

      option :data, default: proc { Hashie::Mash.new }

      def_delegators :@data,
        :id,
        :name,
        :first_name,
        :last_name

      attr_reader :phone, :email
        
      def initialize(**data)
        super
        process_phone_numbers(@data.phone) if @data.respond_to?(:phone)
        process_emails(@data.email) if @data.respond_to?(:email)
      end

      def process_phone_numbers(numbers)
        @phone = numbers.map do |number|
          PhoneNumber.new(
            number: number.value,
            primary: number.primary
          )
        end
      end

      def process_emails(emails)
        @email = emails.map do |email|
          EmailAddress.new(
            email: email.value,
            primary: email.primary
          )
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